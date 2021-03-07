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
