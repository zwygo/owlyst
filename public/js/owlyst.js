function initNewListHandlers() {
  $("#save_new_list").unbind().click(function() {
    var title = $("#new_list_title").val();
    var listItems = [];
    $(".new_list_list_item").each(function() {
      if ($(this).val())
        listItems.push($(this).val());
    });
    if (!title || listItems.length == 0) {
      alert("You must have a title and at least one list item");
      return false;
    }
    var params = {
      title: title,
      items: listItems
    }
    console.log(params);
    $.ajax({
      url: "/list/create",
      data: params,
      dataType: "json",
      success: function(data) {
        console.log(data);
        alert("Success!");
        $("#cancel_new_list").click();
      },
      error: function(err) {console.log(err);}
    });
  });
  $("#cancel_new_list").unbind().click(function() {
    $("#new_list_title").val('');
    var htmlToAdd = $(this).closest(".white_box").find(".list_body").children(".new_list_list_item_wrapper")[0].outerHTML;
    $(this).closest(".white_box").find(".list_body").children(".new_list_list_item_wrapper").remove();
    $(this).closest(".white_box").find(".list_body").append(htmlToAdd);
    initNewListHandlers();
  });
  $(".new_list_list_item").unbind().keyup(function(e) {
    if (e.which == 13) {
      if ($(this).val())
        if ($(this).parent().next().length == 0) {
          $(this).closest(".list_body").append($(this).parent()[0].outerHTML);
          $(this).parent().next().children().focus();
          initNewListHandlers();
        } else {
          $(this).parent().next().children().focus();
        }
    }
  });
}

$(document).ready(function() {
  $(".list_item_wrapper").sortable({
    handle: ".move_list_item",
    stop: function(event, ui) {
      var lid = ui.item.closest(".white_box").attr("lid");
      var newOrder = [];
      ui.item.siblings(".olist_item").andSelf().each(function() {
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

  $(".status_check").change(function() {
    var liid = $(this).closest(".olist_item").attr("liid");
    var status;
    if ($(this).is(":checked")) {
      $(this).closest(".olist_item").addClass("item_done");
      status = "done";
    } else {
      $(this).closest(".olist_item").removeClass("item_done");
      status = "open";
    }
    $.ajax({
      url: "/list_item/update_status",
      data: {liid:liid,status: status},
      dataType: "json",
      success: function(data) {
        console.log(data);
      },
      error: function(err) {console.log(err);}
    });
  });
  initNewListHandlers();
});


