class Transfer < ActiveRecord::Base
=begin
	utilizar callbacks
	after_create,
	before_update
	before_destroy.

	-Al crear una transferencia se debe actualizar el balance de los dos usuarios.

	-Una transferencia no se debe poder actualizar ni eliminar.
=end
	
end
	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :reciever, class_name: "User", foreign_key: "reciever_id"

	validates :sender_id, :reciever_id, presence: true
	validates :amount, numericality: true

	after_create
	
end
