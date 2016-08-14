class AppointmentService
  HEADER = {"Authorization"=>"Bearer #{ENV['CC_ACCESS_TOKEN']}"}
  END_POINT = "https://external-api-gateway.development.carecloud.com/v2".freeze

  def self.create_appointment(appointment)
    appointment_poster = new(appointment)
    appointment_poster.post_appointment
  end

  attr_reader :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def appointment_params
    {
        "appointment": {
            "appointment_status_id": "1",
            "start_time": "#{appointment.start_time}",
            "end_time": "#{appointment.start_time}",
            "location_id": "19669",
            "provider_id": "17138",
            "visit_reason_id": "54562",
            "resource_id": "16627",
            "patients": [{
                             "id": "#{appointment.patient.code}",
                             "comments": "#{appointment_link}"
                         }]
        }
    }
  end

  def appointment_link
    # "localhost:3000/provider/start/#{appointment.room.session_id}"
    "This is a comment and is where the link would go"
  end

  def post_appointment
    HTTParty.post("#{END_POINT}/appointments?location_id=19669", headers: HEADER, body: appointment_params)
  end


end