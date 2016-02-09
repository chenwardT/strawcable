class PollOption < ApplicationRecord
  # TODO: Ensure uniqueness of keys in data_by_poll.
  belongs_to :poll

  scope :data_by_poll, -> (id) { where(poll_id: id).pluck(:text, :count)
                                 .map { |plucked| Hash[[:text, :count].zip(plucked)] } }
end
