# frozen_string_literal: true

class TestsController < Simpler::Controller
  def index
    @time = Time.now
    @tests = Test.all

    render 'tests/index'
  end

  def create; end

  def show
    @test = Test.find(id: params[:id])
  end

  def info
    render plain: "Plain text response"
  end
end
