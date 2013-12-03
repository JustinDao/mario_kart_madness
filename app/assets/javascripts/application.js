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

function Comparator(a,b){
  if (a[0].toUpperCase() < b[0].toUpperCase()) return -1;
  if (a[0].toUpperCase() > b[0].toUpperCase()) return 1;
  return 0;
}


$(document).ready(function() {
  $("#query").bind("keyup", function(){
    var value = $(this).val();
    if (value == ""){
      return;
    }
    $.ajax({
      url: '/search/'+value,
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        $(".search-results").empty();
        data = data.sort(Comparator);
        $.each(data, function(){
          $('.search-results').append($("<a/>", {
            href: this[1],
            text: this[0]
          }));
          $('.search-results').append($("<br/>", {           
          }));
        });     
      }
    });
  });
});