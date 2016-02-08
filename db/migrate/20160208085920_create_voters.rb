class CreateVoters < ActiveRecord::Migration[5.0]
  def change
    create_table :voters do |t|
      t.string :uid
      t.references :poll
    end
  end
end
