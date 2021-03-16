$(function () {
$('[data-toggle="tooltip"]').tooltip()
})
var firebaseConfig = {
  apiKey: "AIzaSyDczogySvDZwXEATmZIKQQAIH0sP_P50Vw",
  authDomain: "datamotto-16e2c.firebaseapp.com",
  databaseURL: "https://datamotto-16e2c-default-rtdb.firebaseio.com",
  projectId: "datamotto-16e2c",
  storageBucket: "datamotto-16e2c.appspot.com",
  messagingSenderId: "522613364093",
  appId: "1:522613364093:web:b87810bc81f4495e8b2814",
  measurementId: "G-K4HSBHXJNW"
};
firebase.initializeApp(firebaseConfig);
firebase.analytics();
var database = firebase.database();
var like_db = database.ref("/like");

function getIP(){
let getIP = '';
$.ajax({
url: 'https://json.geoiplookup.io/api',
dataType: 'json',
async: false,
success: function(data) {
  getIP = data.ip;
}
});
return getIP;
}

function countElement(item,array) {
  var count = 0;
  $.each(array, function(i,v) {
	if (v.post_id == item) count++;
});
  return count;
}

function update_db(){
like_db.on("value", function(snapshot) {
var total_likes = [];

if(snapshot){
$('.dm-rep-btn-loading.spin').hide();
$('.dm-rep-btn').show();
}

snapshot.forEach(function(childSnapshot) {
var childData = childSnapshot.val();
total_likes.push(childData);

$('.dm-rep-btn').each(function(){
if($(this).data('post-id') == childSnapshot.val().post_id && childSnapshot.val().ip == getIP()){
	$(this).attr('data-uid', childSnapshot.key);
}
});
});
$('.total-likes').each(function(){
var pid = $(this).data('post-id');
$(this).html(countElement(pid,total_likes));
});
});
}

update_db();


$(document).ready(function(){

let dottos = $('#dotto ul li').length;
if(dottos <= 1){
$('#dotto ul').removeClass('hasDotto');
}


let likeCookie = localStorage.getItem("like") ? localStorage.getItem("like").split(',') : [];

// check if liked
$('.dm-rep-btn').each(function(){
let post_id = $(this).data('post-id').toString();

if($.inArray(post_id, likeCookie) === -1){
} else {
$(this).addClass('liked');
}
});

// new like

$('.dm-rep-btn').each(function(){
$(this).click(function(){
let bu = $(this);
let post_id = bu.data('post-id').toString();
bu.addClass('btn-disabled');

if($(this).hasClass('liked') && $.inArray(post_id, likeCookie) !== -1){
	bu.removeClass('liked');
	likeCookie.splice( $.inArray(post_id, likeCookie), 1);
	like_db.child(bu.data('uid')).remove();
} else {
	bu.addClass('liked');
	likeCookie.push(post_id.toString());
like_db.push({
		post_id: post_id,
		ip: getIP(),
		created_at: new Date()
	}, function(error) {
  if (error)
	console.log('Error has occured during saving process')
  else
	console.log("Data hss been saved succesfully")
});
}


  window.setTimeout(function(){
      bu.removeClass('btn-disabled');
  },5000);

localStorage.setItem("like", likeCookie);

});
});

// tab and pill

$('.dm-dot-title').click(function(){
$('.dm-dot-title').removeClass('active');
$('.dm-dot-content').removeClass('active');
	$(this).addClass('active');
	$(this).siblings('.dm-dot-content').addClass('active');
});

});
