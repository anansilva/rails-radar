//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require_tree .
$('.datepicker').datepicker({format: 'yyyy-mm-dd'});

// search with icons

const icons = document.getElementsByClassName("banner-icons-type");
for (let icon of icons) {
  icon.addEventListener("click", (event) => {
  console.log(event);
  console.log(event.currentTarget);
});
};
