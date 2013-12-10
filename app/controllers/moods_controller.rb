class MoodsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index

  end

  def create
    Mood.record(params['body-plain'])
    render text: 'Recorded'
  end
end
