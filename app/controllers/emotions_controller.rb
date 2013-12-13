class EmotionsController < ApplicationController
  def index
  end

  def update
    @emotion = Emotion.find(params[:id])
    @emotion.update_attribute(:score, params[:emotion][:score])

    redirect_to emotions_path
  end
end
