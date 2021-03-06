class CreatePropositions < ActiveRecord::Migration
  def change
    create_table :propositions do |t|
      t.string :title, null: false
      t.references :issue, null: false, index: true
      t.references :user, null: false, index: true
      t.timestamps null: false
    end
  end
end
