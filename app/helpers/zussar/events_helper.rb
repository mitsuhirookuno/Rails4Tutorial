module Zussar::EventsHelper

  # FIXME : 同じネームスペースのヘルパを上書いてしまうので、eventsの方に集約しています
  def breadcrumb
    if controller_name == 'events'
      if action_name == 'index'
        template = <<-"EOS"
          <ul class="breadcrumb">
            <li><a href="/">Home</a> <span class="divider">/</span></li>
            <li>Zussar <span class="divider">/</span></li>
            <li class="active">#{controller_name.camelize}</li>
          </ul>
        EOS
      else
        template = <<-"EOS"
        <ul class="breadcrumb">
          <li><a href="/">Home</a> <span class="divider">/</span></li>
            <li><a href="/">Zussar</a> <span class="divider">/</span></li>
          <li>#{link_to( controller_name.camelize, action: 'index' )} <span class="divider">/</span></li>
          <li class="active">#{action_name.camelize}</li>
        </ul>
        EOS
      end
    else
      template = <<-"EOS"
        <ul class="breadcrumb">
          <li><a href="/">Home</a> <span class="divider">/</span></li>
          <li>Zussar <span class="divider">/</span></li>
          <li>#{controller_name.camelize} <span class="divider">/</span></li>
          <li class="active">#{action_name.camelize}</li>
        </ul>
      EOS
    end
    raw(template)
  end

end
