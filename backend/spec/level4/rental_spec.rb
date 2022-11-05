# Please run specs folder by folder
# $ rspec spec/level4

require_relative '../../level4/rental'

RSpec.describe 'Rental' do
  context '.price' do
    let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

    it "returns price per day discount of 10 percent after 1 day" do
      rental = Rental.new(id: 2, car: car, start_date: "2015-03-31", end_date: "2015-04-01", distance: 300)
      expected_return = [{:amount=>6800, :type=>:debit, :who=>:driver},
                         {:amount=>4760, :type=>:credit, :who=>:owner},
                         {:amount=>1020, :type=>:credit, :who=>:insurance},
                         {:amount=>200, :type=>:credit, :who=>:assistance},
                         {:amount=>820, :type=>:credit, :who=>:drivy}]

      expect(rental.price[:actions]).to eq(expected_return)
    end

    it "returns price per day discount of 30 percent after 4 days" do
      rental = Rental.new(id: 3, car: car, start_date: "2015-07-3", end_date: "2015-07-7", distance: 500)
      expected_return = [{:amount=>13800, :type=>:debit, :who=>:driver},
                         {:amount=>9660, :type=>:credit, :who=>:owner},
                         {:amount=>2070, :type=>:credit, :who=>:insurance},
                         {:amount=>500, :type=>:credit, :who=>:assistance},
                         {:amount=>1570, :type=>:credit, :who=>:drivy}]

      expect(rental.price[:actions]).to eq(expected_return)
    end

    it "returns price per day discount of 50 percent after 10 days" do
      rental = Rental.new(id: 3, car: car, start_date: "2015-07-3", end_date: "2015-07-14", distance: 1000)
      expected_return = [{:amount=>27800, :type=>:debit, :who=>:driver},
                         {:amount=>19460, :type=>:credit, :who=>:owner},
                         {:amount=>4170, :type=>:credit, :who=>:insurance},
                         {:amount=>1200, :type=>:credit, :who=>:assistance},
                         {:amount=>2970, :type=>:credit, :who=>:drivy}]

      expect(rental.price[:actions]).to eq(expected_return)
    end
  end
end
