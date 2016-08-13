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
            "start_time": "2016-08-18T00:13:58-05:00",
            "end_time": "2016-08-18T00:14:58-05:00",
            "location_id": "19669",
            "provider_id": "17138",
            "visit_reason_id": "54562",
            "resource_id": "16627",
            "patients": [{
                             "id": "487b6f37-41fb-421d-8f37-aeeb59858d3c",
                             "comments": "#{appointment_link}"
                         }]
        }
    }
  end

  def self.appointment_link
    "localhost:3000/provider/start/#{appointment.room.session_id}"
  end

  def post_appointment
    HTTParty.post("#{END_POINT}/appointments?location_id=19669", headers: HEADER, body: appointment_params)
  end


end