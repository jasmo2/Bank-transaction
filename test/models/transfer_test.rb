require 'test_helper'


class TransferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end#
  test "after transaction users balances should be updated" do
	  	sender = User.create(name: "Simon")
	  	reciever = User.create(name: "Jaime")
	  	Transfer.create(sender_id: sender.id,reciever_id: reciever.id,amount: 30000)
	  	sender.reload
	  	reciever.reload
	  	assert(sender.balance == 20000 )
	  	assert(reciever.balance == 80000 )
  end
  test "rollback transaction when balance update fails" do
	  	sender = User.create(name: "Simon")
	  	reciever = User.create(name: "Jaime")
	  	reciever.should_recieve(:save!).and_raise(Exception.new)
	  	Transfer.create(sender_id: sender.id,reciever_id: reciever.id,amount: 30000)
	  	sender.reload
	  	reciever.reload
	  	assert(sender.balance == 50000 )
	  	assert(reciever.balance == 50000 )
  end
end
