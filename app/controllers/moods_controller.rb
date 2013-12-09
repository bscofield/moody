class MoodsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index

  end

  def create
    Rails.logger.info params.inspect
  end
end
