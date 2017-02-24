class CreateSections < ActiveRecord::Migration
  # 'change' can be used if all commands
  # are reversible.
  def change
    create_table :sections do |t|
      t.string "name"
      t.integer "page_id"
      # same as t.references :page
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content_type"
      t.text "content" 
      t.timestamps     
    end
    add_index("sections", "page_id")
  end

end
