# Transaction keeps the record of a transation data
class Transaction
  attr_reader :from_address, :to_address, :amount

  def initialize(from_address: nil, to_address:, amount:)
    @from_address = from_address
    @to_address = to_address
    @amount = amount
  end
end
