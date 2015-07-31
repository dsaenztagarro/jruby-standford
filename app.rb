require 'active_support/inflector'
require 'grape'
require 'grape-swagger'
require 'java'
require 'jruby'
require 'json'
require 'sinatra/base'

require_relative 'app/helpers/java_helper'

# Require Java libraries
Dir.glob('lib/java/*.jar').each { |lib| require lib }

# Require application classes
Dir.glob('lib/**/*.rb').each { |lib| require lib }
Dir.glob('app/**/*.rb').each { |lib| require lib }

# Microservice providing a wrapper over stanford nlp library
module API
  class V1 < Grape::API
    format :json
    version 'v1'
    prefix :api

    rescue_from :all

    helpers do
      def logger
        V1.logger
      end

      def pipeline_pool
        PipelinePool.instance
      end
    end

    desc 'Returns the annotated info for the text passed'
    params do
      requires :text, type: String, desc: 'The text to be annotated'
    end
    post '/annotate' do
      pipeline = pipeline_pool.fetch
      logger.info "resource fetched #{pipeline}"
      sentences = pipeline.sentences_for(params[:text])
      logger.info "resource released #{pipeline}"
      pipeline_pool.release(pipeline)
      Interpreter.new(sentences).execute
    end

    add_swagger_documentation
  end
end
