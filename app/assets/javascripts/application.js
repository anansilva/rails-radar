//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require underscore
//= require gmaps/google
//= require chat
//= require private_pub
//= require_tree .

$(document).ready(function() {

  if (window.location.search.match(/type|query/)) {
    $('html, body').scrollTop($('#results').offset().top - 140);
  }

  $('.datepicker').datepicker({format: 'yyyy-mm-dd'});

})


