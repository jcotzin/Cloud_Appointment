class PatientService

  HEADER = {"Authorization"=>"Bearer #{ENV['CC_ACCESS_TOKEN']}"}

  attr_reader :guid

  def self.get_from_guid(guid)
    patient_service = new(guid)
    patient_service.patient_hash
  end

  def initialize(guid)
    @guid = guid
  end

  def patient_hash
    {
      external_id: patient["id"],
      first_name: patient["first_name"],
      last_name: patient["last_name"],
      email: patient["email_address"],
      ssn: patient["ssn"],
      phone: patient_phone
    }
  end

  def patient_phone
    patient["phones"].first ? patient["phones"].first["phone_number"] : nil
  end

  def patient
    @patient ||= get_from_api.parsed_response["patient"]
  end

  def get_from_api
    HTTParty.get("https://external-api-gateway.development.carecloud.com/v2/patients/#{guid}", headers: HEADER)
  end
end
