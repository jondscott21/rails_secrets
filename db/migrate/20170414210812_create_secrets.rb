class CreateSecrets < ActiveRecord::Migration[5.1]
  def change
    create_table :secrets do |t|
      t.text :content
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
