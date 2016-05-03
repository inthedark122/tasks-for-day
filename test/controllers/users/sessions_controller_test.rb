require "test_helper"

class Api::V1::Users::SessionsControllerTest < ActionController::TestCase
  setup do
    setup_devise_mapping!
    User.create(
        email: 'foo@bar.com',
        password: '11111111',
        password_confirmation: '11111111'
    )

    @valid_params = {
        user: {
            email: 'foo@bar.com',
            password: '11111111'
        }
    }

    @invalid_params = {
        user: {
            email: 'foo@bar.com',
            password: '22222222'
        }
    }
  end

  teardown do
    User.destroy_all
  end

  test 'xhr success sign in' do
    xhr :post, :create, @valid_params

    assert_response 200
  end

  test 'xhr failure sign in' do
    xhr :post, :create, @invalid_params

    assert_response 401
  end
end