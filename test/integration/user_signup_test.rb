require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {name: "", email: 'user@invalid', password: 'foo', password_confirmation: 'bar'}}
    end
    assert_template 'users/new'
  end

  test 'valid signup information with account validation'  do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {name: 'Fernando', email: 'Fernando@hotmail.com', password: '123456', password_confirmation: '123456'}}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as(user)
    assert_not is_logged_in?
    #invalid token
    get account_activation_path('invalid token', email: user.email)
    assert_not is_logged_in?
    #invalid email
    get account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    #valid activation
    get account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
