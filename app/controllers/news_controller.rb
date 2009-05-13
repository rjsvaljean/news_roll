class NewsController < ApplicationController
  radiant_layout 'Base'
  no_login_required
  before_filter :set_language

  def index
    begin
      @items = Item.find(:all, :order => "created_at DESC").collect{|i| i.translate(session[:language])}
    rescue => e
      flash[:notice] = "Something went wrong"
      redirect_to '/'
    end
  end

  def show
    begin
      @item = Item.find(params[:id]).translate(session[:language])
    rescue => e
      flash[:notice] = "Something went wrong"
      redirect_to '/'
    end
  end

  private
  def accepted_languages()
    # no language accepted
    return [] if request.env["HTTP_ACCEPT_LANGUAGE"].nil?

    # parse Accept-Language
    accepted = request.env["HTTP_ACCEPT_LANGUAGE"].split(",")
    accepted = accepted.map { |l| l.strip.split(";") }
    accepted = accepted.map { |l|
      if (l.size == 2)
        # quality present
        [ l[0].split("-")[0].downcase, l[1].sub(/^q=/, "").to_f ]
      else
        # no quality specified =&gt; quality == 1
        [ l[0].split("-")[0].downcase, 1.0 ]
      end
    }

    # sort by quality
    accepted.sort { |l1, l2| l1[1] <=> l2[1] }
  end

  def set_language
    session[:language] ||= accepted_languages.first[0..1]
  end
end
