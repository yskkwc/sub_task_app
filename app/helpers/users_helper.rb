module UsersHelper
  def current_user?(user)
    #nilガード
    user && user == current_user
  end
end
