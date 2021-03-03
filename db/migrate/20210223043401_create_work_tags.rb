class CreateWorkTags < ActiveRecord::Migration[6.0]
  def change
    create_table :work_tags do |t|
      t.references :work
      t.references :tag

      t.timestamps
    end
  end
end
