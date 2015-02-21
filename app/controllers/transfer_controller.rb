class TransferController < ApplicationController
  def transfer
  	@transference = Transfer.create(parameters)
  	respond_to do |format|
	  	if @transference.valid?
	  		format.html {
			  	flash[:notice] = "Successful Transaction"
			  	redirect_to action: "index" 
	  		}
	  	else
	  		format.html{
	  			render 'index'
	  		}
	  	end
	  end
  end
  def index
  	@transference = Transfer.new
	@users = User.all  	
  	render 'index'
  end
  private
  def parameters
  	params.require(:transfer).permit(:sender_id,:reciever_id,:amount)
  end
end
