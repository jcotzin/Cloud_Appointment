class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :ssn
      t.string :code

      t.timestamps
    end
  end
end
