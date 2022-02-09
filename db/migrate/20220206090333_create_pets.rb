class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.boolean :female
      t.string :dob
      t.boolean :active
      t.references :owner, foreign_key: true
      t.references :animal, foreign_key: true

      t.timestamps
    end
  end
end
