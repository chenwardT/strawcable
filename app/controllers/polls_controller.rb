class PollsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :vote

  def new
    puts user_signed_in?
  end

  def index
    @polls = Poll.all
  end

  def show
    @poll = Poll.find_by_token(params[:token])
  end

  def admin
    @poll = Poll.find_by_admin_token(params[:admin_token])
  end

  def results
    @poll = Poll.find_by_token(params[:token])
    @total_votes = @poll.poll_options.pluck(:count).reduce(&:+)
  end

  # TODO: Cleanup, validate input.
  def vote
    @poll = Poll.find_by_token(params[:token])
    decoded_request = ActiveSupport::JSON.decode(request.body.read)
    option_id = decoded_request['option_id']
    @option = @poll.poll_options.find_by_id(option_id)

    response = {result: "OK"}

    if decoded_request['uid'] == nil
      uid = SecureRandom.urlsafe_base64(46)
      begin
        @poll.cast_vote(@option.id, uid)
        response.update({uid: uid})
      rescue ActiveRecord::RecordNotUnique
        response = {result: "ONE_VOTE_ONLY"}
      end
    else
      begin
        @poll.cast_vote(@option.id, decoded_request['uid'])
        response.update({uid: uid})
      rescue ActiveRecord::RecordNotUnique
        response = {result: 'ONE_VOTE_ONLY'}
      end
    end

    render :json => ActiveSupport::JSON.encode(response)
  end

  def data
    poll = Poll.find_by_token(params[:token])

    respond_to do |format|
      format.json {
        render :json => PollOption.data_by_poll(poll).to_json
      }
    end
  end
end
