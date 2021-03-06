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
//= require turbolinks
//= require_tree .
//= require bootstrap

$(document).ready(function() {
  $('#two_factor_phone').popover({
    title: 'Why do you need my phone number?',
    content: 'We use your phone number for 2-factor authenticaiton. 2-factor authentication provides an extra layer of security when logging in to secure systems. If you provide a phone number here, you will receive a text message with a pin number to access your account. To skip 2 factor authenticaiton and login with just a username and password, leave this field blank. US numbers only.',
    trigger: 'hover'
  })
})

function alert_error(msg)
{
  return  "<div class='alert alert-error'> " + msg
            + "<a class='close' data-dismiss='alert'>&#215;</a>"
            + "</div>"
}
