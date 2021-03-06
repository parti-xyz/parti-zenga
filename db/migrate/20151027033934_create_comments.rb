class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :contents, null: false
      t.references :issue, null: false, index: true
      t.references :user, null: false, index: true
      t.timestamps null: false
    end
  end
end
