class Directors < ActiveRecord::Migration
  def up
    create_table :directors do |t|
      t.string :name
      t.references :company
    end
  end

  def down
    drop_table :directors
  end
end
