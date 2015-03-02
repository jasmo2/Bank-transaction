class TransfersController < ApplicationController
	before_action :fetch_users
  def transfer
    begin
    	@transference = Transfer.create(parameters)
    	respond_to do |format|
  	  	if @transference.valid?
  	  		format.html {
  			  	flash[:notice] = "Successful Transaction"
  			  	# flas[:SenderBalance] = @users.where()
  			  	# flas[:RecieverBalance] = 
  			  	redirect_to action: "index" 
  	  		}
  	  	else
  	  		format.html{
  	  			render 'index'
  	  		}
  	  	end
  	  end
    rescue
      flash[:error] = "Something wrong happened"
      redirect_to action: "index" 
    end
  end
  def index
  	@transference = Transfer.new
  	render 'index'
  end
  private
  def parameters
  	params.require(:transfer).permit(:sender_id,:reciever_id,:amount)
  end
  def fetch_users
  	@users = User.all  	
  end
end
