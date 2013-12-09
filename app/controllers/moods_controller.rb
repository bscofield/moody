class MoodsController < ApplicationController
  def index

  end

  def create
    Rails.logger.info params.inspect
  end
end
