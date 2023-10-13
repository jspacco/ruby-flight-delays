require 'json'

# create a ruby class that can hold the json data in flights.json
class AirportMonth
    attr_accessor :airport_code, :airport_name, :month, :year, :num_of_flights_total, :num_of_delays_carrier, :num_of_delays_late_aircraft, :num_of_delays_nas, :num_of_delays_security, :num_of_delays_weather, :num_of_delays_total, :minutes_delayed_carrier, :minutes_delayed_late_aircraft, :minutes_delayed_nas, :minutes_delayed_security, :minutes_delayed_weather, :minutes_delayed_total
    
    def initialize(json)
        # assign json data to instance variables
        json.each do |key, value|
            instance_variable_set("@#{key}", value) if respond_to?("#{key}=")
        end
    end

    def to_s
        # print all instance variables separated by commas
        # dynamically looking up all fo the instance variables; this is sweet
        instance_variables.map { |var| instance_variable_get(var) }.join(',')
    end
end

def main
    # parse json data in flights.json
    json_data = File.read("flights.json")
    parsed_data = JSON.parse(json_data)
    # iterate through each element in parsed_data
    flights = Array.new
    parsed_data.each do |data|
        flights << AirportMonth.new(data)
        #puts flights[-1]
        #break
    end

    #
    # print all of the airports in the data set
    #
    airports = flights.map { |flight| flight.airport_code }.uniq
    puts airports.join(', ')

    #
    # all of the months and years in the data set
    #
    flights.map { |flight| "#{flight.month}/#{flight.year}" }.uniq.each do |month_year|
        puts month_year
    end

    # how many records have a missing year?
    puts flights.filter { |flight| flight.year == nil }.each { |flight| puts flight }

    #
    # which record has the most:
    # flights
    # delays
    # minutes delayed
    #
    # anything else?
    #

    #
    # which airport has the most delayed flights?
    #

    #
    # which airport has the most:
    # flights, delays, etc
    #

    #
    # which month has the most:
    # flights, delays, etc
    #

    #
    # are there differences between the years?
    # How would you measure that?
    # think about a good metric before you start coding!
    # 

end

if __FILE__ == $0
    main
end