module SessionsHelper
  def sign_in(user)
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>> SIGNED IN USER, TOKEN = #{user.remember_token}"
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
    puts " and self.current_user = #{self.current_user}"
  end
  
  def signed_in?
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>> SIGNED IN TEST, AND CURRENT USER VALUE IS... #{current_user}, test = #{!current_user.nil?}"
    !current_user.nil? 
  end 
  
  def sign_out
    self.current_user = nil
    #@current_user = nil
    puts "=========================== SESSIONS HELPER, FRIKKIN CURRENT USER SHOULDE BE CLEAR: self.current_user = #{self.current_user}"
    #puts "@current_user = #{@current_user}"
    cookies.delete(:remeber_token)
  end
  
  def current_user=(user)
    @current_user = user
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>> CURRENT USER GETTER, user = #{user}, so current_user set to #{@current_user}"
  end
  
  def current_user
    puts "=========================== DEF CURRENT USER, AND IT IS: #{@current_user}"
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    puts "=========================== AFTER TEST IT IS: #{@current_user}"
  end
end
