require 'securerandom'
require_relative './block'
require_relative './transaction'

# A simple implementation of the blockchain
class Blockchain
  MINING_REWARD = 100
  DIFFICULTY = 2

  attr_reader :chain, :pending_transactions

  def initialize(mining_reward: nil, difficulty: nil)
    @chain = [genesis_block]
    @pending_transactions = []
    @mining_reward = mining_reward || MINING_REWARD
    @difficulty = difficulty || DIFFICULTY
  end

  def mine_pending_ransactions(reward_address)
    return if !new_chain? && !valid?

    mine_block_and_add_to_chain
    add_miners_reward(reward_address)
  end

  def add_transaction(transaction)
    @pending_transactions.push(transaction)
  end

  def address_balance(address)
    balance = 0

    chain.each do |block|
      block.transactions.each do |transaction|
        balance -= transaction.amount if transaction.from_address == address
        balance += transaction.amount if transaction.to_address == address
      end
    end

    balance
  end

  def valid?
    chain.each_with_index do |current_block, index|
      next if index.zero?

      prev_block = chain[index - 1]

      return false unless current_block.hash_valid?
      return false unless current_block.prev_hash_valid?(prev_block.hash)

      puts "Valid blockchain, chain length #{chain.size}"
      true
    end
  end

  private

  attr_reader :mining_reward, :difficulty

  def new_chain?
    chain.size == 1
  end

  def latest_block
    chain.last
  end

  def genesis_block
    Block.new(
      timestamp: Time.now,
      transactions: [],
      prev_hash: ''
    )
  end

  def mine_block_and_add_to_chain
    block = Block.new(
      timestamp: Time.now,
      transactions: pending_transactions,
      prev_hash: latest_block.hash
    )

    block.mine_block(difficulty)
    chain.push(block)
  end

  def add_miners_reward(address)
    @pending_transactions = [
      Transaction.new(
        from_address: nil,
        to_address: address,
        amount: mining_reward
      )
    ]
  end
end
