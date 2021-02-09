# frozen_string_literal: true

require_relative 'view'

module Simpler
  class Controller
    HEADERS_TYPES = {
      html: 'text/html',
      plain: 'text/plain'
    }.freeze

    class ValidationError < StandardError; end

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      request.env['simpler.controller'] = self
      request.env['simpler.action'] = action

      set_headers(:html)
      send(action)
      write_response

      response.finish
    end

    def set_status(code)
      raise ValidationError unless validate_status_code!(code)

      response.status = code
    end

    def set_headers(type)
      raise ValidationError unless validate_headers_type!(type)

      response['Content-Type'] = HEADERS_TYPES[type]
      request.env['simpler.content_type'] = type
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def write_response
      body = render_body

      response.write(body)
    end

    def render_body
      View.new(request.env).render(binding)
    end

    def params
      request.params.merge!(request.env['simpler.params'])
    end

    def render(template)
      request.env['simpler.template'] = template
    end

    def validate_status_code!(code)
      Rack::Utils::HTTP_STATUS_CODES.key?(code)
    end

    def validate_headers_type!(type)
      HEADERS_TYPES.key?(type)
    end
  end
end
