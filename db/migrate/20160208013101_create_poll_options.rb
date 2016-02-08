class CreatePollOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_options do |t|
      t.references :poll
      t.text :text
      t.integer :count, default: 0
    end
  end
end
