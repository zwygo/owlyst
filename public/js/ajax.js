OA = {
  call: function(method, params, blockObject, callback, error, scope) {
    var data = JSON.stringify({method:method, params:params});
    $.ajax({
      data: data,
      url: '/api/test',
      type: 'POST',
      dataType: 'json',
      timeout: 15 * 60 * 1000, // 15 minute timeout
      success: function(data) {
        if (data.result && callback)
          callback.call(scope, data.result, data.aid);
        if (data.error) {
          if (error)
            error.call(scope, data.error);
        }
      },
      error: function(req, status, error) {
        console.log({req: req, status: status, error: error});
      }
    });
  },
}