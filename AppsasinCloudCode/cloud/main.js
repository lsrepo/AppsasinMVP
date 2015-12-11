// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  var jb = "Hej I'm justin bieber";
  return jb;
});


Parse.Cloud.define("findsongs", function(request, response) {
  var query = new Parse.Query("Song");
  query.find({
    success: function(results) {
      var baby = [1];
      for (var i = 0; i < results.length; ++i) {
        baby += results[i].get("name");
        results[i].save("name", "just_a_song");
      }
      baby += Parse.Cloud.run("hello");

      response.success(baby);
    },
    error: function() {
      response.error("moviesss lookup failed");
    }
  });
});
