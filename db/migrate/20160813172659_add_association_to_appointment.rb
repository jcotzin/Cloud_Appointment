class AddAssociationToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_reference :appointments, :patient, foreign_key: true
    add_reference :appointments, :provider, foreign_key: true
  end
end
