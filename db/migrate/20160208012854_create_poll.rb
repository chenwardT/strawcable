class CreatePoll < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :question
      t.string :token
      t.string :admin_token
      t.references :user
    end
  end
end
