class Transfer < ActiveRecord::Base
=begin
	utilizar callbacks
	after_create,
	before_update
	before_destroy.

	-Al crear una transferencia se debe actualizar el balance de los dos usuarios.

	-Una transferencia no se debe poder actualizar ni eliminar.
=end
	before_destroy :prevent_update_or_destroy
	before_update :prevent_update_or_destroy
	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :reciever, class_name: "User", foreign_key: "reciever_id"

	validates :sender_id, :reciever_id, presence: true
	validates :amount, numericality: true

	after_save :newBalance
	protected
    def newBalance
=begin
	because I already have the "belogns_to"
       sender = User.find(:sender_id)
       reciever = User.find(:reciever_id)
=end
		sender.balance = sender.balance - self.amount
		reciever.balance = reciever.balance + self.amount
		sender.save!
		reciever.save!
    end
    def prevent_update_or_destroy
	    # self.errors.add_to_base "Cannot update a #{ self.to_s }"
	    raise ActiveRecord::ReadOnlyRecord
  	end
	
end
