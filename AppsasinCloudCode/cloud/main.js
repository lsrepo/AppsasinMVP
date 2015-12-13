// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("getCath", function(request, response) {

  //Use findByUid begins
  var answer;
  Parse.Cloud
    .run('findByUid', {
      param1: "catherine"
    }, {
      success: function(result) {
        answer = result.get("username");
        response.success(answer);
      },
      error: function(error) {
        console.log(error);
        response.error(error);
      }
    });
  //Use findByUid ends

});


Parse.Cloud.define("getPak", function(request, response) {

  //Use findByUid begins
  var answer;
  Parse.Cloud
    .run('findByUid', {
      param1: "pak"
    }, {
      success: function(result) {
        answer = result.get("username");
        response.success(answer);
      },
      error: function(error) {
        console.log(error);
        response.error(error);
      }
    });
  //Use findByUid ends

});



//compare two user's location
Parse.Cloud.define("comparePC", function(request, response) {
  var query = new Parse.Query("User");
  query.find({
    success: function(results) {
      //Use the function get by Id to get pak
      Parse.Cloud.run('testGetParam', {
        param1: "pak"
      }, {
        success: function(result) {
          console.log(result);
          response.success("hejejej");
        },
        error: function(error) {
          console.log(error);
          response.error(error);
        }
      });
      response.success(results);
    },
    error: function() {
      response.error("moviesss lookup failed");
    }
  });
});



//compare two user's location
Parse.Cloud.define("findByUid", function(request, response) {
  var query = new Parse.Query("User");
  query.find({
    success: function(results) {
      var param1 = request.params.param1;

      function findByUid(source, uid) {
        for (var i = 0; i < source.length; i++) {
          if (source[i].get("username") === uid) {
            return source[i];
          }
        }
        throw "Couldn't find object with uid: " + uid;
      }
      var answer = findByUid(results, param1);
      response.success(answer);
    },
    error: function() {
      response.error("moviesss lookup failed");
    }
  });
});


Parse.Cloud.define("getAllUsers", function(request, response) {
  var query = new Parse.Query("User");
  query.find({
    success: function(results) {
      response.success(results[0].get("username"));
    },
    error: function() {
      response.error("moviesss lookup failed");
    }
  });
});



Parse.Cloud.define("testGetParam", function(request, response) {
  var param1 = request.params.param1;
  response.success("success"); //your response
}, function(error) {
  // Make sure to catch any errors, otherwise you may see a "success/error not called" error in Cloud Code.
  response.error("Could not retrieve Posts, error " + error.code + ": " +
    error.message);
});


// Parse.Cloud.define("hello", function(request, response) {
//   var query = new Parse.Query("User");
//   query.equalTo("username", "pak");
//   query.find({
//     success: function(results) {
//       var baby = [1];
//       for (var i = 0; i < results.length; ++i) {
//         baby += results[i].get("name");
//         results[i].save("name", "just_a_song");
//       }
//       baby += Parse.Cloud.run("hello");
//       results = results[0].get("inKuggen");
//       response.success(results);
//     },
//     error: function() {
//       response.error("moviesss lookup failed");
//     }
//   });
// });
