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
//= require jquery_ujs
// require turbolinks
//= require_tree .

$(document).ready(function() {
  $("#query").bind("keypress", function(){
    $(".search-results").empty();
    var value = $(this).val();
    if (value == ""){
      return;
    }
    $.ajax({
      url: '/search/'+value,
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        $.each(data, function(){
          $('.search-results').append($("<a/>", {
            href: data[0][data[0].length-1],
            text: "Hello Word"
          }));
          $('.search-results').append($("<br/>", {           
          }));
        });     
      }
    });
  });
});

jQuery.ajaxSetup({
  beforeSend: function() {
    $('#loading').fadeIn();

  },
  complete: function(){
    $('#loading').hide();
  },
  success: function() {}
});