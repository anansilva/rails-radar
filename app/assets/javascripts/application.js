//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require bootstrap-timepicker
//= require underscore
//= require gmaps/google
//= require chat
//= require private_pub
//= require_tree .

$(document).ready(function() {

  if (window.location.search.match(/type|query/) && $('#results').length > 0) {
    $('html, body').scrollTop($('#results').offset().top - 140);
  }

  $('.datepicker').datepicker({format: 'yyyy-mm-dd'});
  $('#timepicker1').timepicker({format: 'hh:mm'});

})

