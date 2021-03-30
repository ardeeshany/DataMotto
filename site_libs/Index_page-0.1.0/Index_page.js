/*
var json = {
 "analyzing-covid19-in-usa": {
 "title": [ "Analyzing COVID19 in USA" ],
"description": [ "Analyzing Covid 19 reports\n" ],
"author": [
 {
 "name": [ "Ardalan Mirshani" ],
"affiliation": [ "Novartis" ],
"url": [ "https://mirshani.com" ]
}
],
"date": [ "2021-01-11" ],
"base_url": [ "https://www.datamotto.com" ],
"output": {
 "distill::distill_article": {
 "self_contained": [ false ]
}
},
"packages": [ "ggplot2", "forcats" ],
"categories": [ "Visualization", "Modeling" ],
"tech": [ "R", "SqL", "Python" ],
"bibliography": [ "bibliography.bib" ],
"draft": [ false ],
"twitter": {
 "site": [ "@DataMotto" ],
"creator": [ "@DataMotto" ]
},
"link": [ "https://datamotto.com/analyzing-covid19-in-usa" ],
"preview": [ "analyzing-covid19-in-usa_files/figure-html5/unnamed-chunk-7-1.png" ],
"cover_image_url": [ "https://datamotto.com/posts/2020-12-30-analyzing-covid19-in-usa/analyzing-covid19-in-usa_files/figure-html5/unnamed-chunk-7-1.png" ]
},
"new-york-taxi-fare-rate": {
 "title": [ "New York Taxi fare rate" ],
"description": [ "A short description of the post.\n" ],
"author": [
 {
 "name": [ "Nora Jones" ],
"url": [ "https://example.com/norajones" ]
}
],
"date": [ "2020-12-03" ],
"tech": [ "Python" ],
"packages": [ "Matplotlib" ],
"categories": [ "Visualization" ],
"base_url": [ "https://datamotto.com" ],
"output": {
 "distill::distill_article": {
 "self_contained": [ false ]
}
},
"link": [ "https://datamotto.com/New-York-Taxi-Fare-Rate" ],
"preview": [ "https://bookdown.org/kdonovan125/ibis_data_analysis_r4/_main_files/figure-html/ggplot_ex_4_1-2.png" ],
"cover_image_url": [ "https://bookdown.org/kdonovan125/ibis_data_analysis_r4/_main_files/figure-html/ggplot_ex_4_1-2.png" ]
},
"post-template": {
 "title": [ "Post Template" ],
"description": [ "Here is a .html template for Dotto!\n" ],
"author": [ "Pedram" ],
"date": [ "01-26-2021" ],
"output": {
 "distill::distill_article": {
 "self_contained": [ false ]
}
},
"cover_image_url": [ null ]
}
};


var json = {
"analyzing-covid19-in-usa": {
    "title": "Analyzing COVID19 in USA",
    "description": "Analyzing Covid 19 reports\n",
    "author": [
      {
        "name": "Ardalan Mirshani",
        "affiliation": "Novartis",
        "url": "https://mirshani.com"
      }
    ],
    "date": "2021-01-11",
    "base_url": "https://www.datamotto.com",
    "output": {
      "distill::distill_article": {
        "self_contained": false
      }
    },
    "packages": ["ggplot2", "forcats"],
    "categories": ["Visualization", "Modeling"],
    "tech": ["R", "SqL", "Python"],
    "bibliography": "bibliography.bib",
    "draft": false,
    "twitter": {
      "site": "@DataMotto",
      "creator": "@DataMotto"
    },
    "preview": "unnamed-chunk-7-1.png"
  },
"new-york-taxi-fare-rate": {
    "title": "New York Taxi fare rate",
    "description": "A short description of the post.\n",
    "author": [
      {
        "name": "Nora Jones",
        "url": "https://example.com/norajones"
      }
    ],
    "date": "2020-12-03",
    "tech": "Python",
    "packages": "Matplotlib",
    "categories": "Visualization",
    "base_url": "https://datamotto.com",
    "output": {
      "distill::distill_article": {
        "self_contained": false
      }
    },
    "preview": "https://bookdown.org/kdonovan125/ibis_data_analysis_r4/_main_files/figure-html/ggplot_ex_4_1-2.png"
  },
"post-template": {
    "title": "My new blue Dotto",
    "description": "A new format of panelset",
    "author": "Ardeeshany",
    "date": "02-11-2021",
    "output": {
      "html_document": {
        "template": {}
      }
    }
  },
"forcats": {
    "title": "Forcats",
    "description": "A short description of the post.\n",
    "author": [
      {
        "name": "Ardalan Mirshani",
        "url": "mirshani.com"
      }
    ],
    "date": "2020-12-03",
    "tech": "Python",
    "packages": "Matplotlib",
    "categories": "Visualization",
    "base_url": "https://datamotto.com",
    "output": "DataMotto::Dotto",
    "preview": "https://bookdown.org/kdonovan125/ibis_data_analysis_r4/_main_files/figure-html/ggplot_ex_4_1-2.png"
  },
"sdf": {
    "title": "sdf",
    "author": "Ardalan Mirshani",
    "date": "2/20/2021",
    "output": {
      "rmdformats::html_clean": {
        "self_contained": false
      }
    }
  }
}
*/

$(document).ready(function(){
// end json
var j = 0;
var more = 4; // default cart

function getPost(kind, category, language){

let arr_post = [];
more = more + 4; // add 8 cart for more
let inte = 0;

$.each(json, function(i, v){
	j++;
	let title = v.title_on_cards;
	let img = v.cover_image_url[0];
	let desc = v.desc_on_cards;
	let author = v.author[0].name;
	let aff = v.author[0].affiliation;
	let authUrl = v.author[0].url;
	let date = v.date;
	let cats = v.categories;
	let tech = v.tech;
	let tags = '';
	let techn = '';
	let link = v.link;

	if(link){
		link = link;
	} else {
		link = '#';
	}

	if(img == null){
		img = 'resources/images/default.jpg';
	} else {
		img = img;
	}

	$.each(cats, function(d,t){
		tags += '<span class="badge badge-pill badge-info mr-1">'+t+'</span>';
	});

		$.each(tech, function(x,y){
	if(y === 'r'){
		techn += '<div class="dm-dot-icon r-color mr-1" title="R"><i class="fab fa-r-project"></i></div>';
	} else if(y === 'python') {
		techn += '<div class="dm-dot-icon python-color mr-1" title="Python"><i class="fab fa-python"></i></div>';
		} else if(y === 'julia') {
		techn += '<div class="dm-dot-icon julia-color mr-1" title="Julia">Jul</div>';
		} else if(y === 'sql') {
		techn += '<div class="dm-dot-icon sql-color mr-1" title="SqL"><i class="fas fa-database"></i></div>';
	} else if(y === 'rcpp') {
		techn += '<div class="dm-dot-icon rcpp-color mr-1" title="Rcpp">Rc</i></div>';
	} else if(y === 'node') {
		techn += '<div class="dm-dot-icon node-color mr-1" title="Node"><i class="fab fa-node-js"></i></div>';
	} else if(y === 'bash') {
		techn += '<div class="dm-dot-icon bash-color mr-1" title="Bash"><i class="fas fa-terminal"></i></div>';
	} else if(y === 'js') {
		techn += '<div class="dm-dot-icon js-color mr-1" title="Js">JS</div>';
	} else if(y === 'd3') {
		techn += '<div class="dm-dot-icon d3-color mr-1" title="D3">d3</i></div>';
	} else if(y === 'stan') {
		techn += '<div class="dm-dot-icon stan-color mr-1" title="Stan">St</i></div>';
	} else {
		techn += '<div class="dm-dot-icon others-color mr-1" title="Others">'+y+'</div>';
	}

	});

	if(kind == 'filter'){


		if(category.length){
			$.each(category, function(i, cts){
				if($.inArray(cts, cats) === -1){
				} else {
					arr_post.push(v);
				}
			});
		}
		if(language.length){
			$.each(language, function(i, lng){
				if($.inArray(lng, tech) === -1){
				} else {
					arr_post.push(v);
				}
			});
		}

	} else if(kind == 'more') {
	inte++;
		if(inte == more){
	$('#dm-post').append('<div class="col-md-4 col-sm-6 dm-posts pr-md-1 mb-1">'+
   '<div class="card rounded">'+
	'<div class="card-body">'+
	 '<div class="row">'+
		'<div class="col-md-12 dm-posts-img mb-4">'+
		  '<img class="w-100" src="'+img+'"/>'+
		'</div>'+
		'<div class="col-md-12">'+
		'<a href="'+link+'"><h2>'+title+'</h2></a>'+
	  '<ul class="row dm-posts-desc pl-3">'+
		'<li class="d-inline-block pr-1"><i class="far fa-clock"></i> '+date+'</li>'+
		'<li class="d-inline-block dm-author"><i class="far fa-user"></i> <a target="_blank" href="'+authUrl+'">'+author+'</a></li>'+
	  '</ul>'+
	  '<p>'+desc+'</p>'+
	  '<div class="row">'+
		'<div class="col-12">'+
			tags+
		'</div>'+
		'<div class="col-12 mt-2">'+
			'<div class="row justify-content-end">'+techn+'</div>'+
		'</div>'+
	  '</div>'+
		'</div>'+
	  '</div>'+
	'</div>'+
   '</div>'+
'</div>');;
		}
	} else {
	if(j <= more){
	$('#dm-post').prepend('<div class="col-md-4 col-sm-6 dm-posts pr-md-1 mb-1">'+
   '<div class="card rounded">'+
	'<div class="card-body">'+
	 '<div class="row">'+
		'<div class="col-md-12 dm-posts-img mb-4">'+
		  '<img class="w-100" src="'+img+'"/>'+
		'</div>'+
		'<div class="col-md-12">'+
		'<a href="'+link+'"><h2>'+title+'</h2></a>'+
	  '<ul class="row dm-posts-desc pl-3">'+
		'<li class="d-inline-block pr-1"><i class="far fa-clock"></i> '+date+'</li>'+
		'<li class="d-inline-block dm-author"><i class="far fa-user"></i> <a target="_blank" href="'+authUrl+'">'+author+'</a></li>'+
	  '</ul>'+
	  '<p>'+desc+'</p>'+
	  '<div class="row">'+
		'<div class="col-12">'+
			tags+
		'</div>'+
		'<div class="col-12 mt-2">'+
			'<div class="row justify-content-end">'+techn+'</div>'+
		'</div>'+
	  '</div>'+
		'</div>'+
	  '</div>'+
	'</div>'+
   '</div>'+
'</div>');
}
	}

});

var result = [];
$.each(arr_post, function (i, e) {
    var matchingItems = $.grep(result, function (item) {
       return item.title === e.title;
    });
    if (matchingItems.length === 0){
        result.push(e);
    }
});

if(kind == 'filter'){
if(result.length){
$.each(result, function(i, v){
	let title = v.title_on_cards;
	let img = v.cover_image_url[0];
	let desc = v.desc_on_cards;
	let author = v.author[0].name;
	let aff = v.author[0].affiliation;
	let authUrl = v.author[0].url;
	let date = v.date;
	let cats = v.categories;
	let tech = v.tech;
	let tags = '';
	let techn = '';


	if(img == null){
		img = 'resources/images/default.jpg';
	} else {
		img = img;
	}

	$.each(cats, function(d,t){
		tags += '<span class="badge badge-pill badge-info mr-1">'+t+'</span>';
	});

		$.each(tech, function(x,y){
	if(y === 'r'){
		techn += '<div class="dm-dot-icon r-color mr-1" title="R"><i class="fab fa-r-project"></i></div>';
	} else if(y === 'python') {
		techn += '<div class="dm-dot-icon python-color mr-1" title="Python"><i class="fab fa-python"></i></div>';
		} else if(y === 'julia') {
		techn += '<div class="dm-dot-icon julia-color mr-1" title="Julia">Jul</div>';
		} else if(y === 'sql') {
		techn += '<div class="dm-dot-icon sql-color mr-1" title="SqL"><i class="fas fa-database"></i></div>';
	} else if(y === 'rcpp') {
		techn += '<div class="dm-dot-icon rcpp-color mr-1" title="Rcpp">Rc</i></div>';
	} else if(y === 'node') {
		techn += '<div class="dm-dot-icon node-color mr-1" title="Node"><i class="fab fa-node-js"></i></div>';
	} else if(y === 'bash') {
		techn += '<div class="dm-dot-icon bash-color mr-1" title="Bash"><i class="fas fa-terminal"></i></div>';
	} else if(y === 'js') {
		techn += '<div class="dm-dot-icon js-color mr-1" title="Js">JS</div>';
	} else if(y === 'd3') {
		techn += '<div class="dm-dot-icon d3-color mr-1" title="D3">d3</i></div>';
	} else if(y === 'stan') {
		techn += '<div class="dm-dot-icon stan-color mr-1" title="Stan">St</i></div>';
	} else {
		techn += '<div class="dm-dot-icon others-color mr-1" title="Others">'+y+'</div>';
	}

	});

	$('#dm-post').prepend('<div class="col-md-4 col-sm-6 dm-posts pr-md-1 mb-1">'+
   '<div class="card rounded">'+
	'<div class="card-body">'+
	 '<div class="row">'+
		'<div class="col-md-12 dm-posts-img mb-4">'+
		  '<img class="w-100" src="'+img+'"/>'+
		'</div>'+
		'<div class="col-md-12">'+
		'<h2>'+title+'</h2>'+
	  '<ul class="row dm-posts-desc pl-3">'+
		'<li class="d-inline-block pr-1"><i class="far fa-clock"></i> '+date+'</li>'+
		'<li class="d-inline-block dm-author"><i class="far fa-user"></i> <a target="_blank" href="'+authUrl+'">'+author+' ('+aff+')</a></li>'+
	  '</ul>'+
	  '<p>'+desc+'</p>'+
	  '<div class="row">'+
		'<div class="col-12">'+
			tags+
		'</div>'+
		'<div class="col-12 mt-2">'+
			'<div class="row justify-content-end">'+techn+'</div>'+
		'</div>'+
	  '</div>'+
		'</div>'+
	  '</div>'+
	'</div>'+
   '</div>'+
'</div>');
});


} else {
	$('#dm-post').html('<div class="alert alert-info w-100"> <strong>Oops! There is no such dotto! </div>');
}
}
}

getPost('all', false, false);

// more

$('#dm-more-btn').click(function(){
	getPost('more', false, false);
});

// filter

let cat_filter = [];
let tech_filter = [];

$('#do-filter').click(function() {
$('#dm-post').html('');
	if(cat_filter.length > 0 || tech_filter.length > 0){
		getPost('filter', cat_filter, tech_filter);
	} else {
		getPost('all', false, false);
	}
});

$('.dropdown-menu input[type="checkbox"]').click(function(){
	let name = $(this).attr('name');
	let kind = $(this).parent().parent().parent().data('kind');

	if ($(this).is(':checked')) {
		if(kind == 'categories'){
			cat_filter.push(name);
		} else if(kind == 'languages'){
			tech_filter.push(name);
		}
	} else {
		if(kind == 'categories'){
			cat_filter.splice( $.inArray(name, cat_filter), 1);
		} else if(kind == 'languages'){
			tech_filter.splice( $.inArray(name, tech_filter), 1);
		}
	}
});

$('#dm-filter-menu').on('click', function(e) {
    e.stopPropagation();
});
});


