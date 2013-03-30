class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.boolean :read, :default => false
      t.string :url

      t.timestamps
    end
  end
end
