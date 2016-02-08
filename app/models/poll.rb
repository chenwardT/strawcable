class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :poll_options
  has_many :voters

  before_create :generate_tokens

  def to_s
    "\"#{question}\" by #{user.username}"
  end

  # Will raise ActiveRecord::RecordNotUnique if the uid has already voted
  # on this poll.
  def cast_vote(poll_option_id, uid)
    voters.create(uid: uid)
    poll_options.find_by_id(poll_option_id).increment!(:count)
  end

  private

  # TODO: Ensure no collisions.
  def generate_tokens
    self.token = SecureRandom.urlsafe_base64(8, true)
    self.admin_token = SecureRandom.urlsafe_base64(32, true)
  end

end