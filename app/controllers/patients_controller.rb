class PatientsController < ApplicationController
  # before_filter :authorize


  def new
  end

  def create
    patient = Patient.new(patient_params)
    if patient.save
      session[:patient_id] = patient.id
      redirect_to '/'
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
