Swagger::Docs::Config.register_apis({
    '1.0' => {
        # the extension used for the API
        # :api_extension_type => :json,
        # the output location where your .json files are written to
        :api_file_path => 'public/',
        # the URL base path to your API
        :base_path => 'http://tasks-for-day.herokuapp.com',
        # if you want to delete all .json files at each generation
        :clean_directory => true,
        # :parent_controller => API,
        # add custom attributes to api-docs
        :attributes => {
            :info => {
                :title => 'Tasks for the day',
                :description => 'Create a new task.'
            }
        }
    }
})