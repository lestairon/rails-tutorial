require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fernando)
    @other_user = users(:lestairon)
  end

  test 'unsuccessful edit' do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name:  "", email: "foo@invalid", password:"foo",password_confirmation: "bar"}}
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 4 errors.'
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as @user
    assert_redirected_to edit_user_url(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Lestairon'
    email = 'lestairon@hotmail.com'
    patch user_path(@user), params: {user: {name: name, email: email}}
    # byebug
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: {user: {name: @user.name, email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end