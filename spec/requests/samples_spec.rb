# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Samples' do
  describe 'GET /samples' do
    it 'lists all samples' do
      samples = create_list(:sample, 2)

      get '/samples'

      expect(response).to have_http_status(:success)
      expect(response.parsed_body).to match(
        samples.map { |sample| JSON.parse(SampleSerializer.new(sample).to_json) }
      )
    end
  end

  describe 'POST /samples' do
    it 'create a sample' do
      post '/samples', params: { title: 'foo', body: 'bar' }

      expect(response).to have_http_status(:created)

      expect(response.parsed_body).to include(title: 'foo', body: 'bar')
    end
  end

  describe 'GET /samples/:id' do
    it 'returns a sample' do
      sample = create(:sample)

      get "/samples/#{sample.id}"

      expect(response.parsed_body).to eq(JSON.parse(SampleSerializer.new(sample).to_json))
    end
  end

  describe 'PATCH /samples/:id' do
    it 'updates a sample' do
      sample = create(:sample, title: 'foo', body: 'bar')

      patch "/samples/#{sample.id}", params: { body: 'baz' }

      expect(response).to have_http_status(:no_content)
      expect(sample.reload).to have_attributes(
        title: 'foo', body: 'baz'
      )
    end
  end

  describe 'DELETE /samples/:id' do
    it 'destroys a sample' do
      sample = create(:sample)

      delete "/samples/#{sample.id}"

      expect(response).to have_http_status(:no_content)
      expect(Sample.find_by(id: sample.id)).to be_nil
    end
  end
end
