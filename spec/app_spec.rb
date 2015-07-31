require 'spec_helper'

describe API::V1 do
  def app
    API::V1
  end

  let(:story_body) { File.read('spec/fixtures/story_body.txt') }
  let(:post_data) { { text: story_body.to_json }.to_json }

  describe 'POST /api/v1/annotate' do
    it 'returns the annotated story' do
      post '/api/v1/annotate', post_data, { 'CONTENT_TYPE' => 'application/json' }
      expect(last_response.status).to eq(201)
      parsed_response = JSON.parse(last_response.body)
      %w(JJ NN VBG DT NNS VBP RB WRB PRP VBN MD VB CC JJR CD NNP VBZ TO IN
         JJS VBD WP RP POS).each do |pos|
        expect(parsed_response.include? pos).to eq(true)
      end
    end

    it "returns error 500 if 'text' param isn't passed" do
      post '/api/v1/annotate', {}, { 'CONTENT_TYPE' => 'application/json' }
      expect(last_response.status).to eq(500)
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response['error']).to eq('text is missing')
    end
  end
end
