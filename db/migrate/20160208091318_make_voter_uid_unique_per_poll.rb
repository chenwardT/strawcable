class MakeVoterUidUniquePerPoll < ActiveRecord::Migration[5.0]
  def change
    add_index :voters, [:uid, :poll_id], unique: true
  end
end
