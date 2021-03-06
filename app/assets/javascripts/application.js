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
          $('.search-results').append($("<div>", {
            class: "search-result"
          }).append($("<a/>", {
            href: this[1],
            text: this[0],
            class: "search-result-link"
          })));
        });     
      }
    });
  });
});

$(document).ready(function() {
  if ($(".messages").length > 0){
    setInterval(function(){
      $.ajax({
        url: '/messages/get/',
        dataType: 'json',
        type: 'GET',
        success: function(data) {
          $(".messages").empty();
          $.each(data, function(){
            if ($(".admin").length > 0) {
              $('.messages').append($("<tr/>",{
                class: "post"
              }).append($("<td/>", {
                text: this[0],
                class: "poster"
              })).append($("<td/>", {
                text: this[1],
                class: "message"
              })).append($("<td/>",{class: "delete-post"}).append($("<div/>", {
                text: "X",
                class: "delete-post-"+this[2]
              }))));

              var mid = this[2];

              $(".delete-post-"+mid).bind("click", function() {
                $.ajax({
                  url: '/messages/'+mid,
                  type: 'DELETE'
                });
              });
            }
            else {
              $('.messages').append($("<tr/>",{
                class: "post"
              }).append($("<td/>", {
                text: this[0] + ":",
                class: "poster"
              })).append($("<td/>", {
                text: this[1],
                class: "message"
              })));
            }
          });  
        }
      });
    }, 250);
  }
});

$(document).ready(function() {
  $(".message_submit").bind("click", addMessage);
  
  $("#text").bind("keydown", function(e) {
    updateLetterCount(e);
    enterSend(e);
  });
  $("#text").bind("keyup", function(e){
    updateLetterCount(e);
  });
});

function updateLetterCount(e) {
    var value = $("#text").val();
  var length = value.length
  var leftover = 140 - length

  $(".letter-count").empty();

  $(".letter-count").append(leftover);

  if (leftover < 0){
    $(".letter-count").addClass("warning");
  }
  else{
    $(".letter-count").removeClass("warning");
  }
}

function enterSend(e) {
  if (e.keyCode == 13) {
    addMessage();
  }
}

function addMessage(){
  var value = $("#text").val();
  if (value == ""){
    return;
  }
  $.ajax({
    url: '/messages/add',
    data: { 
      message: { 
        text: value 
      } 
    },
    type: 'POST',
    success: function(){
      $("#text").val("");
      $(".letter-count").empty();
      $(".letter-count").append(140)
    }
  });
};