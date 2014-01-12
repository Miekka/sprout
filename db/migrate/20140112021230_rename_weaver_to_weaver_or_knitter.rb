class RenameWeaverToWeaverOrKnitter < ActiveRecord::Migration
  def up
    rename_column :users, :weaver, :weaver_or_knitter
  end

  def down
    rename_column :users, :weaver_or_knitter, :weaver
  end
end
