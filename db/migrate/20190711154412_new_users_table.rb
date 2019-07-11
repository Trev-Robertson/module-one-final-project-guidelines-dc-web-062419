class NewUsersTable < ActiveRecord::Migration[5.0]
  def change
      create_table :users do |t|
        t.string :name
        t.integer :streak_high_score
        t.integer :timed_high_score
        t.integer :last_score
      end
  end
end