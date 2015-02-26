require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it do
  	sender = User.create(name: "Simon")
  	reciever = User.create(name: "Jaime")
  	Transfer.create(sender_id: sender.id,reciever_id: reciever.id,amount: 30000)
  	sender.reload
  	reciever.reload
  	expect(sender.balance).to eq(20000 )
  	expect(reciever.balance).to eq(80000 )
  end
  it do
    sender = User.create(name: "Simon")
    reciever = User.create(name: "Jaime")
    allow(reciever).to receive(:save!).and_raise(Exception.new)
    begin
      Transfer.create(sender_id: sender.id,reciever: reciever,amount: 30000)
    rescue Exception
      
    end
    sender.reload
    reciever.reload
    expect(sender.balance).to eq(50000 )
    expect(reciever.balance).to eq( 50000 )
  end
  it do
  	sender = User.create(name: "Simon")
  	reciever = User.create(name: "Jaime")
  	transference = Transfer.create(sender_id: sender.id,reciever: reciever,amount: 30000)
    expect{transference.destroy!}.to raise_exception(ActiveRecord::ReadOnlyRecord)

  end
end
