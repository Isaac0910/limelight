class AddConfirmationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmation_token, :string, :index => true, :null => false, :default => 'CONFIRMED'
  end
end
