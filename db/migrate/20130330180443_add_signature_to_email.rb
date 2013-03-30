class AddSignatureToEmail < ActiveRecord::Migration
  def change
  	add_column :emails, :signature, :string
  end
end
