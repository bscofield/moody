class MoodsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @moods = Mood.order('recorded_at DESC').to_a
  end

  def create
    Mood.record(params)

    if params['emotion']
      redirect_to moods_path
    else
      render nothing: true
    end
  end
end
