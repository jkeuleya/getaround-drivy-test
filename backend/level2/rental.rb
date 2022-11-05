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
    total_days = end_date - start_date + 1

    nbr_days_eligible_to_50prct_discount = total_days > 10 ? total_days - 10 : 0
    nbr_days_eligible_to_30prct_discount = total_days > 4 ? total_days - 4 - nbr_days_eligible_to_50prct_discount : 0
    nbr_days_eligible_to_10prct_discount = total_days > 1 ? total_days - 1 - nbr_days_eligible_to_30prct_discount - nbr_days_eligible_to_50prct_discount : 0

    total_discount_for_50prct_eligible_days = get_discount(nbr_days_eligible_to_50prct_discount, 50)
    total_discount_for_30prct_eligible_days = get_discount(nbr_days_eligible_to_30prct_discount, 30)
    total_discount_for_10prct_eligible_days = get_discount(nbr_days_eligible_to_10prct_discount, 10)

    time_based_price = (end_date - start_date + 1) * car.price_per_day
    time_based_price_with_discount = time_based_price - total_discount_for_50prct_eligible_days - total_discount_for_30prct_eligible_days -total_discount_for_10prct_eligible_days
    distance_based_price = distance * car.price_per_km

    (time_based_price_with_discount + distance_based_price).to_i
  end

  def get_discount(days, percentage)
    discount_per_day = car.price_per_day * percentage / 100

    discount_per_day * days
  end
end
