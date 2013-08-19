module ApplicationHelper

  def breadcrumb
    if controller_name == 'welcome'
      template = <<-"EOS"
        <ul class="breadcrumb">
          <li class="active">Home</li>
        </ul>
      EOS
    elsif action_name == 'index'
      template = <<-"EOS"
        <ul class="breadcrumb">
          <li><a href="/">Home</a> <span class="divider">/</span></li>
          <li class="active">#{controller_name.camelize}</li>
        </ul>
      EOS
    else
      template = <<-"EOS"
        <ul class="breadcrumb">
          <li><a href="/">Home</a> <span class="divider">/</span></li>
          <li><a href="/#{controller_name}/index">#{controller_name.camelize}</a> <span class="divider">/</span></li>
          <li class="active">#{action_name.camelize}</li>
        </ul>
      EOS
    end

    raw(template)
  end


  def render_googlemap( lat, lon )
    template = <<-"EOS"
<script type="text/javascript">
google_map_loaded = false ;
function load_only_once() {
  if( google_map_loaded == true ) {
    return false ;
  }
  else {
    google_map_initialize();
    google_map_loaded = true ;
    return true ;
  }
}
function google_map_initialize() {
  var latlng = new google.maps.LatLng("#{lat}","#{lon}");
  var opts = {
    zoom: 15,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"), opts);

  var image = '/images/pin.png' ;
  var myLatLng = new google.maps.LatLng("#{lat}","#{lon}");
  var beachMarker = new google.maps.Marker({
      position: myLatLng,
      map:      map,
      icon:     image,
      title:    'ココ！'
  });
}
</script>
    EOS
    raw(template)
  end

end
