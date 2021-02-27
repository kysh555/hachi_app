class CreateWorkTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :work_tag_relations do |t|
      t.references :work, foreign_key: true
      t.references :tag,  foreign_key: true

      t.timestamps
    end
  end
end
