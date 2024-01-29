# frozen_string_literal: true

class SampleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :summary

  def summary
    "title: #{object.title} body: #{object.body}"
  end
end
