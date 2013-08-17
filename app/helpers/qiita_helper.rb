module QiitaHelper

  def image_tag_completion_missing( icon_url, options = {} )
    if icon_url == '/icons/medium/missing.png'
      icon_url = '/images/no_image.png'
    end
    image_tag( icon_url, options )
  end

end
