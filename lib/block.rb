require 'digest'
require 'json'

# Block keeps the list of transactions and previous blocks hash
# A blocks hash is the hash of all of the attributes it holds
class Block
  attr_reader :hash, :prev_hash, :transactions

  def initialize(timestamp:, transactions:, prev_hash: '')
    @timestamp = timestamp
    @transactions = transactions
    @prev_hash = prev_hash
    @hash = calculate_hash
    @nounce = 0
  end

  def calculate_hash
    Digest::SHA256.hexdigest(to_s)
  end

  def mine_block(difficulty)
    while hash[0, difficulty] != ('0' * difficulty)
      @nounce = nounce + 1
      @hash = calculate_hash
    end

    puts "Block mined: #{hash}"
  end

  def hash_valid?
    hash == calculate_hash
  end

  def prev_hash_valid?(prev_block_hash)
    prev_block_hash == prev_hash
  end

  def to_s
    "#{timestamp} #{prev_hash} #{transactions.to_json} #{nounce}"
  end

  private

  attr_reader :timestamp, :nounce
end
