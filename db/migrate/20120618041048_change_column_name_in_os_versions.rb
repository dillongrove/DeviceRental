class ChangeColumnNameInOsVersions < ActiveRecord::Migration
  def change
    remove_column :devices, :os_ver_id
    add_column :devices, :os_version_id, :integer
  end
end
