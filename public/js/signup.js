$(document).ready(function() {
  $("#show_login_form").click(function() {
    $(".signup_form").hide();
    $(".login_form").show();
    return false;
  });
  $("#show_signup_form").click(function() {
    $(".login_form").hide();
    $(".signup_form").show();
    return false;
  });
  $("#login_button").click(function() {
    var params = {
      email: $("#login_email").val(),
      password: $("#login_password").val()
    }
    $.ajax({
      url: "/login",
      data: params,
      dataType: "json",
      success: function(data) {
        if (data.error) {
          alert(data.error);
          return false;
        }
        else
          window.location = "/";
      },
      error: function(err) {console.log(err);}
    });
    return false;
  });
});