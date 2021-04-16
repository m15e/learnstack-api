class ChangeLinkColumnName < ActiveRecord::Migration[6.0]
  def change    
    rename_column :links, :type, :medium
  end  
end
