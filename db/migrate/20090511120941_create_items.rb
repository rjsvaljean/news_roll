class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :en_headline
      t.string :en_leadtext
      t.text :en_content
      t.string :de_headline
      t.string :de_leadtext
      t.text :de_content

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
