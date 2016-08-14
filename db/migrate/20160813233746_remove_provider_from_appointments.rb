class RemoveProviderFromAppointments < ActiveRecord::Migration[5.0]
  def change
    remove_column :appointments, :provider_id, :string
  end
end
