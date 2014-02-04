require 'test_helper'

class CountdownPagesControllerTest < ActionController::TestCase
  setup do
    @countdown_page = countdown_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countdown_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create countdown_page" do
    assert_difference('CountdownPage.count') do
      post :create, countdown_page: { end_date: @countdown_page.end_date, owner: @countdown_page.owner }
    end

    assert_redirected_to countdown_page_path(assigns(:countdown_page))
  end

  test "should show countdown_page" do
    get :show, id: @countdown_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @countdown_page
    assert_response :success
  end

  test "should update countdown_page" do
    put :update, id: @countdown_page, countdown_page: { end_date: @countdown_page.end_date, owner: @countdown_page.owner }
    assert_redirected_to countdown_page_path(assigns(:countdown_page))
  end

  test "should destroy countdown_page" do
    assert_difference('CountdownPage.count', -1) do
      delete :destroy, id: @countdown_page
    end

    assert_redirected_to countdown_pages_path
  end
end
