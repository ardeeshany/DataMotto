$(document).ready(function(){
	$('#dotto ul li').each(function(){
	var bu = $(this);
	var id = $(this).data('id');
		$(this).find('.click-dots').on('click',function(){
		if(!bu.hasClass('dotto-active')){
			$('#dotto > ul > li').removeClass('dotto-active');
			$('#dm-post .dotto-container').stop().slideUp();
			bu.addClass('dotto-active');
			$('#dm-post .dotto-container[data-id="'+id+	'"]').stop().slideDown();
			}
		});
	});
});

$(document).ready(function(){

let dottos = $('#dotto ul li').length;
if(dottos <= 1){
$('#dotto ul').removeClass('hasDotto');
}
// tab and pill

$('.dm-dot-title').click(function(){
$('.dm-dot-title').removeClass('active');
$('.dm-dot-content').removeClass('active');
	$(this).addClass('active');
	$(this).siblings('.dm-dot-content').addClass('active');
});

});
