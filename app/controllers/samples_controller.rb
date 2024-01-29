# frozen_string_literal: true

class SamplesController < ApplicationController
  def index
    render json: Sample.all, each_serializer: SampleSerializer
  end

  def show
    render json: Sample.find(params[:id]), serializer: SampleSerializer
  end

  def create
    sample = Sample.create(title: params[:title], body: params[:body])

    render json: sample, serializer: SampleSerializer, status: :created
  end

  def update
    Sample.find(params[:id]).update!({ title: params[:title], body: params[:body] }.compact)

    head :no_content
  end

  def destroy
    Sample.destroy(params[:id])

    head :no_content
  end
end
