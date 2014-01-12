class ChangeWeaverToText < ActiveRecord::Migration
  def up
    change_column :users, :weaver, :string
  end

  def down
    change_column :users, :weaver, :boolean
  end
end
