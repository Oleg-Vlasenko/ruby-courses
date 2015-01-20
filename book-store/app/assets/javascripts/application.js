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
//= require bootstrap
//= require_tree .


$(function () {
  $(document)
    .on('click', '.oi-btn-del', function () {
      $(this).parents('tr').toggleClass('danger');
      var del_flag_id = $(this).attr('del-flag-id');
      $('#' + del_flag_id).val('1');
    });
    
  $('#rating-bar').on('click', 'input', function(event) {
    var StarNum = parseInt($(this).next().attr('value'));
    $('#rating').attr('value', StarNum);
    for(var i=1; i<=StarNum; i++) {
      $('.rating-star[value = ' + i + ']').removeClass('empty').addClass('marked');
    }
    for(i=StarNum+1; i<=5; i++) {
      $('.rating-star[value = ' + i + ']').removeClass('marked').addClass('empty');
    }
  });
  
  $('#btn-empty-cart').on('click', function(event){
    $('#myModal').modal('show');
  });

  
});