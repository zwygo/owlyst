$(document).ready(function() {
  $(".list_item_wrapper").sortable({
    handle: ".move_list_item",
    stop: function(event, ui) {
      var lid = ui.item.closest(".white_box").attr("lid");
      var newOrder = [];
      ui.item.siblings().andSelf().each(function() {
        newOrder.push($(this).attr("liid"));
      });
      console.log(newOrder);
      $.ajax({
        url: "/list/reorder_items",
        data: {order:newOrder,lid: lid},
        dataType: "json",
        success: function(data) {
          console.log(data);
        },
        error: function(err) {console.log(err);}
      });
    }
  });

  $(".edit_list").click(function() {
    $(this).closest(".white_box").find(".list_item_wrapper").addClass("edit_mode");
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

  $(".delete_list").click(function() {
    var c = confirm("Are you sure you want to delete?");
    if (!c)
      return false;
    var lid = $(this).closest(".white_box").attr("lid");
    $.ajax({
      url: "/list/destroy",
      data: {lid: lid},
      dataType: "json",
      success: function(data) {
        console.log(data);
        if (data && data.lid) {
          $("[lid='" + data.lid + "']").remove();
        }
      },
      error: function(err) {console.log(err);}
    });
    return false;
  });
});
