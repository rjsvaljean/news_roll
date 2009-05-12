class NewsController < ApplicationController
  radiant_layout 'Base'
  no_login_required

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

end
