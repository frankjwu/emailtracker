class AddBodyToEmail < ActiveRecord::Migration
  def change
  	add_column :emails, :body, :text
  end
end
