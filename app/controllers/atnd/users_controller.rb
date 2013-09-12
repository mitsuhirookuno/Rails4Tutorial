# -*- encoding: utf-8 -*-

#
# AtndAPIを利用する：コントローラー
#
# @see http://api.atnd.org/ AtndAPI
# @see http://rubygems.org/gems/atndr AtndAPIのGem
#

class Atnd::UsersController < ApplicationController

  skip_before_filter :authenticate

  def show
    search_result = Atndr::User.new.get_user( owner_id: params[:id] )
    @events = search_result
  end

end
