class CreateTables < ActiveRecord::Migration
  def self.up
    create_table "pages", :force => true do |t|
      t.string   "url"
      t.text     "body"

      t.timestamps
    end

  end

  def self.down
    drop_table :pages
  end
end

