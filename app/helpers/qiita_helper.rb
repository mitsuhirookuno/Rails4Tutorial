# -*- encoding: utf-8 -*-

module QiitaHelper

  #
  # 画像なしアイコンのリンクを補完する
  # （画像なしアイコンは、このパスでは取得出来ない為）
  #
  # @param icon_url [String] アイコンのURL
  # @param options [Hash] image_tagのパラメータ
  #
  def image_tag_completion_missing( icon_url, options = {} )
    if icon_url == '/icons/medium/missing.png'
      icon_url = '/images/no_image.png'
    end
    image_tag( icon_url, options )
  end

end
