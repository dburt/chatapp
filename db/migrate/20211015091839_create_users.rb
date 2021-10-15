class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :token
      t.datetime :token_expires_at
      t.datetime :last_signed_in_at
      t.integer :sign_in_count

      t.timestamps
    end
  end
end
