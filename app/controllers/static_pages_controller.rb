class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to emails_url
    end
  end

  def about
  end
end
