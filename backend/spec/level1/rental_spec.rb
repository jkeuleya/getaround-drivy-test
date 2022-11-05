# Please run specs folder by folder
# $ rspec spec/level1

require_relative '../../level1/rental'

RSpec.describe 'Rental' do
  context '.price' do
    let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

    it 'returns 6000 cents with a null distance' do
      rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 0)

      expect(rental.price).to eq({id: 1, price: 6000})
    end

    it 'returns 7000 cents with a distance' do
      rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)

      expect(rental.price).to eq({id: 1, price: 7000})
    end
  end
end
