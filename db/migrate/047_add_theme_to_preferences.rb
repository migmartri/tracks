class AddThemeToPreferences < ActiveRecord::Migration
  def self.up
    add_column :preferences, :theme, :string, :default => 'default'
  end

  def self.down
    remove_column :preferences, :theme
  end
end
