# frozen_string_literal: true

Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/info', 'tests#info'
  get '/tests/:id', 'tests#show'
  post '/tests/:title/:level', 'tests#create'
end
