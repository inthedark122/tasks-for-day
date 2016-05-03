require 'test_helper'

class Api::V1::TasksControllerTest < ActionController::TestCase
  setup do
    setup_devise_mapping!
    @valid_params = {
        task: {
            name: 'New task',
            description: 'My new test task'
        }
    }

    @empty_name = {
        task: {
            description: 'My new test task'
        }
    }
  end

  test 'xhr get index' do
    xhr :get, :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test 'xhr success task create' do
    assert_difference 'Task.count', 1 do
      xhr :post, :create, @valid_params
      assert_response :ok
    end
  end

  test 'xhr error task create not name' do
    assert_difference 'Task.count', 0 do
      xhr :post, :create, @empty_name
      assert_response :unprocessable_entity
    end
  end

  test 'xhr start task' do
    xhr :patch, :start, id: tasks(:start)
    assert_response :ok
    assert_not_nil assigns(:task).started_at
  end

  test 'xhr start task invalid' do
    xhr :patch, :start, id: 0
    assert_response :unprocessable_entity
  end

  test 'xhr finish task' do
    xhr :patch, :finish, id: tasks(:finish)
    assert_response :ok
    assert_not_nil assigns(:task).finished_at
  end

  test 'xhr finish task invalid' do
    xhr :patch, :finish, id: 0
    assert_response :unprocessable_entity
  end

  test 'xhr delete task' do
    assert_difference 'Task.count', -1 do
      xhr :delete,  :destroy, id: tasks(:delete)
      assert_response :success
    end
  end

  test 'xhr error delete task' do
    assert_difference 'Task.count', 0 do
      xhr :delete,  :destroy, id: 0
      assert_response :unprocessable_entity
    end
  end
end