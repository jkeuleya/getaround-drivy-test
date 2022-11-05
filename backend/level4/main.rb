require 'json'
require_relative 'entity'
require_relative 'car'
require_relative 'rental'

def read_input_file
  file_path = File.join(File.expand_path(File.dirname(__FILE__)), 'data/input.json')

  JSON.parse(File.read(file_path))
end

def get_rentals(input_file)
  cars = []
  rentals = []

  input_file['cars'].each do |car|
    cars << Car.new(
      id: car['id'],
      price_per_day: car['price_per_day'],
      price_per_km: car['price_per_km']
    )
  end

  input_file['rentals'].each do |rental|
    car = cars.select { |car| car.id == rental['car_id'] }.first

    rentals << Rental.new(
      id: rental['id'],
      car: car,
      start_date: rental['start_date'],
      end_date: rental['end_date'],
      distance: rental['distance']
    )
  end

  rentals
end

def write_in_output_file(rentals)
  rentals_with_price = rentals.map(&:price)

  output = JSON.generate({ "rentals" => rentals_with_price },
    { indent: "  ", space: " ", array_nl: "\n", object_nl: "\n" })

  File.open(File.join(File.expand_path(File.dirname(__FILE__)), 'data/output.json'), 'w') do |file|
    file.puts(output)
  end
end

def run
  rentals = get_rentals(read_input_file)
  write_in_output_file(rentals)
end

if $0 == __FILE__
  run
end
