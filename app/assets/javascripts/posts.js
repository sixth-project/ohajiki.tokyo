// Dropzone.autoDiscover = false;

// var headlineDropzone = new Dropzone("#upload-dropzone", {

//   url: "/upload_photo", // You can override url of form in here.

//   maxFilesize: 5, // in MB

//   parallelUploads: 1,

//   acceptedFiles:'.jpg, .png, .jpeg, .gif', // type of files

//   init: function(){

//     this.on('addedfile', function(file) {

//       // Called when a file is added to the list.

//     });

//     this.on('sending', function(file, xhr, formData) {

//       // Called just before each file is sent.

//     });

//     this.on('success', function(file, json) {

//       // Called when file uploaded successfully.

//     });

//   }

// });

// instagramAPI
// $(function(){
//   var $container = $('.instagrm_thum_col');
//   var html = "";

//   $.ajax({
//     url: 'https://api.instagram.com/v1/users/self/media/recent/?access_token=1987747396.9cc0eef.b0bb30438f034e3e91d1890fe7e5ca0f',
//     type: 'POST',
//     dataType: 'json',
//   })
//   .done(function(data) {
//     console.log("success");
//     $.each(data.data, function(i, item) {
//       var imageUrl = item.images.standaed_resolution.url;
//       var link = item.link;
//       html += '<div class="mdl-cell mdl-cell--2-col"><a class="instagrm_thum" href="'+link+'"><img src="'+imageUrl+'" alt=""></a></div>';
//     });
//   })
//   .fail(function() {
//     console.log("error");
//   })
//   .always(function() {
//     console.log("complete");
//     $container.html(html);
//   });
// });