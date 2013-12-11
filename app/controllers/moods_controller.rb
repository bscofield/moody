class MoodsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @moods = Mood.order('recorded_at DESC').all
  end

  def create
    Mood.record(params)
    render text: 'Recorded'
  end
end
