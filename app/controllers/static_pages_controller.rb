class StaticPagesController < ApplicationController
  def about

  end

  def link
  end

  def privacy
  end

  def terms
  end

  def certbot
    id = ENV['LETS_ENCRYPT_ID']
    secret = ENV['LETS_ENCRYPT_SECRET']

    if id.nil? || secret.nil?
      render_404 and return
    end

    unless id == params[:id]
      render_404 and return
    end

    render text: "#{id}.#{secret}"
  end
end
