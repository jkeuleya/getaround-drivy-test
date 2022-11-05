require 'date'

class Rental
  COMMISSION_RATE = 0.3.freeze

  attr_reader :id, :car, :start_date, :end_date, :distance, :total_days

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
    @total_days = (@end_date - @start_date + 1)
  end

  def price
    { id: id, price: calculate_price, commission: commission }
  end

  private

  def commission
    total_commission = calculate_price * COMMISSION_RATE

    insurance = total_commission / 2

    assistance_fee = total_days * 100 # We're initially in cents, we want euros

    drivy_fee = total_commission - insurance - assistance_fee

    {
      insurance_fee: insurance.to_i,
      assistance_fee: assistance_fee.to_i,
      drivy_fee: drivy_fee.to_i
    }
  end

  # Sorry for the naming of each variable. I wanted to be accurate for the test
  # In general, I would run Rubocop and fix all problems
  def calculate_price
    # We count every time how many days are eligible for each discount
    nbr_days_eligible_to_50prct_discount = total_days > 10 ? total_days - 10 : 0
    nbr_days_eligible_to_30prct_discount = total_days > 4 ? total_days - 4 - nbr_days_eligible_to_50prct_discount : 0
    nbr_days_eligible_to_10prct_discount = total_days > 1 ? total_days - 1 - nbr_days_eligible_to_30prct_discount - nbr_days_eligible_to_50prct_discount : 0

    # Now we apply the specified discount to each days
    total_discount_for_50prct_eligible_days = get_discount(nbr_days_eligible_to_50prct_discount, 50)
    total_discount_for_30prct_eligible_days = get_discount(nbr_days_eligible_to_30prct_discount, 30)
    total_discount_for_10prct_eligible_days = get_discount(nbr_days_eligible_to_10prct_discount, 10)

    # Finally, we start to compute total time based price without any discount.
    # To this, we substract the sum of each discount
    # And we finish by adding the distance based price
    time_based_price = total_days * car.price_per_day
    time_based_price_with_discount = time_based_price - total_discount_for_50prct_eligible_days - total_discount_for_30prct_eligible_days -total_discount_for_10prct_eligible_days
    distance_based_price = distance * car.price_per_km

    (time_based_price_with_discount + distance_based_price).to_i
  end

  def get_discount(days, percentage)
    discount_per_day = car.price_per_day * percentage / 100

    discount_per_day * days
  end
end
