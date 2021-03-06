# frozen_string_literal: true

class TestsController < Simpler::Controller
  def index
    @time = Time.now
    @tests = Test.all

    set_status 200

    render 'tests/list'
  end

  def create
    @test = Test.create(title: params[:title], level: params[:level])

    set_status 201

    render 'tests/show'
  rescue StandardError => e
    set_status 422

    render plain: "The test has not been created! Error: #{e}!"
  end

  def show
    @test_id = params[:id].to_i

    @test = Test.find(id: @test_id)

    set_status 200
  end

  def info
    set_status 200
    set_headers(:plain)

    render plain: "Plain text response"
  end
end
