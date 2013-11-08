class Qiita::UsersController < ApplicationController

  skip_before_filter :authenticate

  def index
  end

  def show
    @page_size = 20
    @offset = 1
    if params.key?(:page) == false
      @page = 1
    else
      @page = Integer(params.fetch(:page))
    end
    @offset += ((@page - 1 ) * @page_size )
    @parameters = { per_page: @page_size, page: @page }
    @qiita_timelines = Qiita.user_items( params[:id], @parameters )
  end

end
