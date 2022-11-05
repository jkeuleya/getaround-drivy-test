# Please run specs folder by folder
# $ rspec spec/level3

require_relative '../../level3/rental'

RSpec.describe 'Rental' do
  context '.price' do
    let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

    it 'returns specific values with a null distance' do
      rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 0)

      expect(rental.price[:commission]).to eq({assistance_fee: 300, drivy_fee: 540, insurance_fee: 840})
    end

    it 'returns specific values with a distance' do
      rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)

      expect(rental.price[:commission]).to eq({assistance_fee: 300, drivy_fee: 690, insurance_fee: 990})
    end

    it "returns price per day discount of 10 percent after 1 day organized by tiers" do
      rental = Rental.new(id: 2, car: car, start_date: "2015-03-31", end_date: "2015-04-01", distance: 300)

      expect(rental.price[:commission]).to eq({assistance_fee: 200, drivy_fee: 820, insurance_fee: 1020})
    end

    it "returns price per day discount of 30 percent after 4 days organized by tiers" do
      rental = Rental.new(id: 3, car: car, start_date: "2015-07-3", end_date: "2015-07-7", distance: 500)

      expect(rental.price[:commission]).to eq({assistance_fee: 500, drivy_fee: 1570, insurance_fee: 2070})
    end

    it "returns price per day discount of 50 percent after 10 days organized by tiers" do
      rental = Rental.new(id: 3, car: car, start_date: "2015-07-3", end_date: "2015-07-14", distance: 1000)

      expect(rental.price[:commission]).to eq({assistance_fee: 1200, drivy_fee: 2970, insurance_fee: 4170})
    end
  end
end
