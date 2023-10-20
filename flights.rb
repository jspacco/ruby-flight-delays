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
        instance_variables.map { |var| "#{var} = #{instance_variable_get(var)}" }.join(',')
    end
end

def startcode flights
    #
    # print all of the airports in the data set
    #
    airports = flights.map { |flight| flight.airport_code }.uniq
    #puts airports.join(', ')

    #
    # all of the months and years in the data set
    #
    flights.map { |flight| "#{flight.month}/#{flight.year}" }.uniq.each do |month_year|
        #puts month_year
    end

    # how many records have a missing year?
    #puts flights.count { |flight| flight.year == nil || flight.year == "" }
    #puts flights.filter { |flight| flight.year == nil }.each { |flight| puts flight }


    # check the types
    #puts flights[0].num_of_flights_total.class

    #
    # percentage of flights delayeda across all airports
    #
    num_delays = flights.map { |flight| flight.num_of_delays_total.to_i }.reduce(:+)
    total_flights = flights.map { |flight| flight.num_of_flights_total.to_i }.reduce(:+)
    #num_delays = flights.map { |flight| flight.num_of_delays_total.to_i }.sum
    #total_flights = flights.map { |flight| flight.num_of_flights_total.to_i }.sum
    puts "percentage of flights delayed: #{total_flights}, #{num_delays}, #{num_delays.to_f / total_flights.to_f * 100.0}"


    #
    # average minutes of delay per flight that is delayed, and per flight overall
    #
    total_delayed_minutes = flights.map { |flight| flight.minutes_delayed_total.to_i }.sum
    puts "average delayed minutes per delayed flight: #{total_delayed_minutes.to_f / num_delays.to_f}"
    puts "average dleayed minutes per flight: #{total_delayed_minutes.to_f / total_flights.to_f}"

end

def update(hash, flight, keyfield, field)
    # get the value of the instance variable with name field from flight record
    # and add it to the hash
    if !hash.has_key? flight.send(keyfield.to_sym)
        hash[flight.send(keyfield.to_sym)] = flight.send(field.to_sym).to_i
    else
        hash[flight.send(keyfield.to_sym)] += flight.send(field.to_sym).to_i
    end
end

def update2(hash, flight, key, field)
    if !hash.has_key? key
        hash[key] = flight.send(field.to_sym).to_i
    else
        hash[key] += flight.send(field.to_sym).to_i
    end
end

def partone(flights)
    # compute the total number of flights for each airport
    # and print the top 10 airports with the most flights
    airports = Hash.new
    delays = Hash.new
    delay_minutes = Hash.new
    flights.each do |flight|
        update(airports, flight, :airport_code, :num_of_flights_total)

        update(delays, flight, :airport_code, :num_of_delays_total)

        update(delay_minutes, flight, :airport_code, :minutes_delayed_total)
    end

    # print the top 10 airports with the most flights
    puts "flights by airport sorted"
    airports.sort_by { |k, v| -v }.each do |airport, num_flights|
        puts "#{airport} #{num_flights}"
    end

    puts "delays by airport sorted"
    delays.sort_by { |k, v| -v }.each do |airport, num_delays|
        puts "#{airport} #{num_delays}"
    end

    puts "percentage of flights delayed per airport"
    airports.each do |airport, num_flights|
        puts "#{airport} #{num_flights} #{delays[airport]} #{(delays[airport].to_f / num_flights.to_f * 100.0).round(1)}"
    end

    puts "average delayed minutes per delayed flight per airport"
    airports.each do |airport, num_flights|
        puts "#{airport} #{num_flights} #{delay_minutes[airport]} #{(delay_minutes[airport].to_f / delays[airport].to_f).round(1)}"
    end

    puts "average delayed minutes per flight per airport"
    airports.each do |airport, num_flights|
        puts "#{airport} #{num_flights} #{delay_minutes[airport]} #{(delay_minutes[airport].to_f / num_flights.to_f).round(1)}"
    end


    
end

def partone_c flights
    # analyze data per year
    total = Hash.new
    delays = Hash.new
    delay_minutes = Hash.new
    flights.each do |flight|
        update(total, flight, :year, :num_of_flights_total)

        update(delays, flight, :year, :num_of_delays_total)

        update(delay_minutes, flight, :year, :minutes_delayed_total)
    end

    puts "total number of flights per year"
    total.each do |year, num_flights|
        puts "#{year} #{num_flights}"
    end

    puts "percentage of flights delayed per year"
    total.each do |year, num_flights|
        puts "#{year} #{num_flights} #{delays[year]} #{(delays[year].to_f / num_flights.to_f * 100.0).round(1)}"
    end

    puts "average delayed minutes per delayed flight per year"
    total.each do |year, num_flights|
        puts "#{year} #{num_flights} #{delay_minutes[year]} #{(delay_minutes[year].to_f / delays[year].to_f).round(1)}"
    end

    puts "average delayed minutes per flight per year"
    total.each do |year, num_flights|
        puts "#{year} #{num_flights} #{delay_minutes[year]} #{(delay_minutes[year].to_f / num_flights.to_f).round(1)}"
    end


end

def partone_b flights
# compute the total number of flights for each month
    # and print the top 10 months with the most flights
    flightmonths = Hash.new
    delaymonths = Hash.new
    flights.each do |flight|
        key = "#{flight.airport_code}-#{flight.month}"
        update2(flightmonths, flight, key, :num_of_flights_total)

        update2(delaymonths, flight, key, :num_of_delays_total)
    end

    puts "\n\n\n\n"

    # sort by key and print
    puts "flights by month sorted"
    flightmonths.sort_by { |k, v| k }.each do |month, num_flights|
        puts "#{month} #{num_flights} #{delaymonths[month]} #{(delaymonths[month].to_f / num_flights.to_f * 100.0).round(1)}"
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

    #startcode(flights)

    #partone(flights)
    partone_c(flights)

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