class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :discipline, :string
    add_column :users, :school, :string
    add_column :users, :website, :string
    add_column :users, :school_major, :string
    add_column :users, :graduated, :boolean
    add_column :users, :weaver, :boolean
  end
end
