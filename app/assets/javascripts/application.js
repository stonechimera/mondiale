// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .


// Initializer
$(document).ready(function() {
  $(document).foundation();

  setToWindowHeight($('.content'), $(window).height());
  welcomePage();

  // offcanvas menu
  sidebar();

  // bind delete photo Button
  deletePictureBtn();

  // generate google map
  if ($('#map-canvas').length) {
    var map = new GoogleMap();
  }

  $('#chapters-list').sortable({
    axis: "y",
    update: function(event,ui){
      var data = $('#chapters-list').sortable('serialize');
      $.ajax({
        data: data,
        url: "/trips/sort_chapter_items",
        type: 'post'
      })
    }
  });


  // Bind flash alerts
  flashAlertEffect();

  // bind dropdown list buttons
  // dropdownListBtn();


  if ($('#user.form').length) {
    setYtoM($('#user.form .form-container'));
  }

});