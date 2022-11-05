require 'date'

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
  end

  def price
    { id: id, price: calculate_price }
  end

  private

  def calculate_price
    time_based_price = (end_date - start_date + 1) * car.price_per_day
    distance_based_price = distance * car.price_per_km

    time_based_price.to_i + distance_based_price
  end
end
