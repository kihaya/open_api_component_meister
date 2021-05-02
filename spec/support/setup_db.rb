require "active_record"

# See: https://moneyforward.com/engineers_blog/2015/02/27/how_to_write_test_for_activerecord_extensions/

ActiveRecord::Base.configurations = {'test' => {adapter: 'sqlite3', database: ':memory:'}}
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration[6.1]
  def self.up
    create_table(:users) do |t|
      t.string :name
      t.integer :age
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
