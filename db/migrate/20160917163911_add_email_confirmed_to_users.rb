class AddEmailConfirmedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_confirmed, :timestamp, :index => true
  end
end
