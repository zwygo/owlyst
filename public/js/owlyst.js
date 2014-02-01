$(document).ready(function() {
  $(".list_item_wrapper").sortable({handle: ".move_list_item"});

  $(".edit_list").click(function() {

  });

  $("#create_list").click(function() {
    var title = $("#create_name").val();
    var items = [];
    $(".create_item").each(function() {
      if ($(this).val())
        items.push($(this).val());
    });
    var params = {
      title: title,
      items: items
    }
    console.log(params);
    $.ajax({
      url: "/list/create",
      data: params,
      dataType: "json",
      success: function(data) {
        console.log(data);
      },
      error: function(err) {console.log(err);}
    });
  });
});
