class Passport < ActiveRecord::Migration
  def up
    add_column :directors, :passport, :string
  end

  def down
    remove_column :directors, :passport
  end
end
