class PatientsController < ApplicationController
  # before_filter :authorize


  def new
  end

  def create
    patient = Patient.new(patient_params)
    patient_hash = PatientService.get_from_guid(params[:code])
    patient.email = patient_hash[:email]
    patient.first_name = patient_hash[:first_name]
    patient.last_name = patient_hash[:last_name]
    patient.phone = patient_hash[:phone]
    patient.external_id = patient_hash[:external_id]

    if params[:ssn] == patient_hash[:ssn] && patient.save
      session[:patient_id] = patient.id
      redirect_to patient
    else
      redirect_to '/signup'
    end
  end


  private

  def patient_params
    # what are we getting from the form and what we are storing
    params.require(:patient).permit(:password, :password_confirmation)
  end


end
