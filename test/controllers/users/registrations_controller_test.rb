require 'test_helper'

class Api::V1::Users::RegistrationsControllerTest < ActionController::TestCase
  setup do
    setup_devise_mapping!
    @valid_params = {
        user: {
            email: 'foo@bar.com',
            password: '11111111',
            password_confirmation: '11111111'
        }
    }

    @empty_params = {
        user: {
            email: '',
            password: '',
            password_confirmation: ''
        }
    }
  end

  test 'xhr success sign up' do
    assert_difference 'User.count', 1 do
      xhr :post, :create, @valid_params

      assert_response 201
    end
  end


  test 'xhr failure sign up without params' do
    assert_no_difference 'User.count', 0 do
      xhr :post, :create, @empty_params

      assert_response 422
    end
  end
end