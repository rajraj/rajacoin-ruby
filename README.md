## A simple blockchain implementation in Ruby

```ruby
# Create a blockchain
# default mining_reward = 100
# default difficulty = 2 (the higher the difficulty the longer it takes to mine the block)

blockchain = Blockchain.new

# or override defaults
blockchain = Blockchain.new(mining_reward: 200, difficulty: 3)

# Add a transaction
transaction = Transaction.new(
  from_address: '6640a932e7d6fc3667ccf3cf04ec1686',
  to_address: '0faab73ebba42d190205fb1313222545',
  amount: 100
)

blockchain.add_transaction(transaction)

# then you can mine the block

# The miners address required so the mining reward
# can be transferred for if successful. The miners
# reward will be added to the pending_transactions
# to include in the next block
miners_address = '9807264545ad0e87f74804ea21a5c286'

blockchain.mine_pending_ransactions(miners_address)

# Check address balance
blockchain.address_balance(miners_address)
```
> This is an experiment and for learning purpose only.

Credits goes to https://www.youtube.com/watch?v=zVqczFZr124&list=PLzvRQMJ9HDiTqZmbtFisdXFxul5k0F-Q4
