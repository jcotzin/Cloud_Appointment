class AddSsnToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :ssn, :string
  end
end
