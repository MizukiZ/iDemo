class AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    if params[:token_id]

    
      #get corresponding account data using token id
      account = Account.where(token_id: params[:token_id]).take

      #user is found
      if account != nil
      # set user info in session
      session[:current_user] = account
      # return json data to js file
      return render json: {"result"=>"login","userInfo"=> session[:current_user]}
      else
        #user is not found
        return render json: {"result"=>"fail","message"=> "No corresponding user"}
      end

    end

    #  when token is sent
    if params[:token]
      # get certificate using firebase token library
      FirebaseIdToken::Certificates.request
      # verity the token using firebase token library
      tokenData = FirebaseIdToken::Signature.verify(params[:token])

      # return json user data to js file
      return render json: {"tokenData"=> tokenData}
    end
  end

  def logout
    # destroy the session when user logout
    reset_session
    return render json: {"sessionD"=> "delete"}
  end

  def index
  end

  def new
  end

  def create
    token_id = params[:token_id]
    name = params[:name]
    email = params[:email]

    begin
    account = Account.create(token_id: token_id,name: name,email: email)
     # set user info in session
     session[:current_user] = account
     # return json data to js file
     return render json: {"userInfo"=> session[:current_user]}
    rescue StandardError => e
      # return fail result and error message
      return render json: {"result"=> "fail", "message" => e}
    end

  end

end
