# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SampleSerializer, type: :serializer do
  describe '#to_json' do
    it 'serializes the object' do
      sample = build(:sample)

      parsed_object = JSON.parse(described_class.new(sample).to_json)

      expect(parsed_object).to include(
        'title' => sample.title,
        'body' => sample.body,
        'created_at' => sample.created_at,
        'updated_at' => sample.updated_at,
        'summary' => "title: #{sample.title} body: #{sample.body}"
      )
    end
  end
end
