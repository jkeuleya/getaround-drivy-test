# Please run specs folder by folder
# $ rspec spec/level2

require_relative '../../level2/rental'

RSpec.describe 'Rental' do
  context '.price' do
    let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

    it 'returns 5600 cents with a null distance' do
      rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 0)

      expect(rental.price).to eq({id: 1, price: 5600})
    end

    it 'returns 6600 cents with a distance' do
      rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)

      expect(rental.price).to eq({id: 1, price: 6600})
    end

    it "returns price per day discount of 10 percent after 1 day" do
      rental = Rental.new(id: 2, car: car, start_date: "2015-03-31", end_date: "2015-04-01", distance: 300)

      expect(rental.price).to eq({id: 2, price: 6800})
    end

    it "returns price per day discount of 30 percent after 4 days" do
      rental = Rental.new(id: 3, car: car, start_date: "2015-07-3", end_date: "2015-07-7", distance: 500)

      expect(rental.price).to eq({id: 3, price: 13800})
    end

    it "returns price per day discount of 50 percent after 10 days" do
      rental = Rental.new(id: 3, car: car, start_date: "2015-07-3", end_date: "2015-07-14", distance: 1000)

      expect(rental.price).to eq({id: 3, price: 27800})
    end
  end
end
