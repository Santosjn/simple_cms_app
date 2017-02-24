class CreateUsers < ActiveRecord::Migration
  # def change
  #   create_table :users do |t|

  #     t.timestamps
  #   end
  # end

  # Types of columns
  # binary    float
  # boolean   integer
  # date      string
  # datetime  text
  # decimal   time

  # Options
  # :limit    => size
  # :default	=> value
  # :null		=> true/false
  # :precision  => number
  # :scale	=> number

  def up
    create_table :users do |t|
      # t.column "first_name", :string, options
      ## ===> short version below
      # t.string "name"
      t.column "first_name", :string, :limit => 25
      t.string "last_name", :limit => 50
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
     
      # t.datetime "created_at"
      # t.datetime "updated_at"
      # ===> shortcut!
      t.timestamps
    end
  end
  def down
    drop_table :users
  end

end
