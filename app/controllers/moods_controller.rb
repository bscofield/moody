class MoodsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index

  end

  def create
    render text: params.inspect
  end
end
