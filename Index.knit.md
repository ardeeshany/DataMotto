---
title: "Data Motto"
description: |
  The main page of Data Motto.
author:
  - name: "Ardalan Mirshani"
    url: "mirshani.com"
date: "18 April, 2021"
output: DataMotto::Index
---


```{=html}
<section id="dm-splash">
<div class="container">
<div class="row clear">
<div class="col-md-6 pt-md-5 mt-5" id="dm-title">
	<h1>Share Efficiently<br/>
	Your Data Experience
	</h1>
	<p>Data science is an inter-disciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from many structural and unstructured data. Data science is related to data mining, machine learning and big data.</p>
	<form action="./Get_started.html">
<input class="btn gradient-button text-white rounded-pill" type="submit" value="Learn More" />
</form>
</div>
<div class="col-md-6" id="dm-splash-img">
	<img class="w-100" src="./resources/images/splash-main.jpg"/>
</div>
</div>
</div>
</section>
```


```{=html}
<section id="github-star-section">
<div class="container">
<div class="row">
<div class="col-md-7 mt-5 mb-5">
<h2>If you like Data Motto, star us on Github!</h2>
</div>
<div class="col-md-5 mt-5 mb-5 text-left pt-2">

<a class="github-button" href="https://github.com/ardeeshany/DataMotto" data-color-scheme="no-preference: light; light: light; dark: light;" data-size="large" data-show-count="true" aria-label="Star ardeeshany/DataMotto on GitHub">Star</a>

</div>
</div>
</div>
</section>
```





```{=html}

<section id="dm-middle" class="pt-5 pb-5">
<div class="container">
<h2>OUR DOTTOS</h2>
<div class="pt-5 row justify-content-center">

<div class="dottos julia-color"><i class="icon-julialang-icon"><i class="path1"></i><i class="path2"></i><i class="path3"></i></i> <span>1</span></div>
<div class="dottos node-color"><i class="fab fa-node-js"></i> <span>1</span></div>
<div class="dottos python-color"><i class="fab fa-python"></i> <span>1</span></div>
<div class="dottos r-color"><i class="fab fa-r-project"></i> <span>1</span></div>
<div class="dottos sql-color"><i class="icon-file-sql"></i> <span>1</span></div>
</div>
</div>
</section>

```

<!-- Section Our Dottos ------------------------>


```{=html}
<!-- start cart -->
<section id="dm-post-section" class="pt-3 pb-5">
<div class="container">
<div class="dropdown pull-right">
  <button type="button" class="btn gradient-button text-white rounded-pill dropdown-toggle" data-toggle="dropdown">
    <i class="fas fa-filter"></i> Filter
  </button>

<div class="dropdown-menu p-1" id="dm-filter-menu">
	<div class="row">
	<div class="col-6" id="dm-filter-cat" data-kind="categories">
	<div class="dropdown-header"><b>CATEGORIES</b></div>
    <a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="Articles"> Articles</label></a>
    <a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="Modeling"> Modeling</label></a>
    <a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="Visualization"> Visualization</label></a>
	</div>
	<div class="col-6" id="dm-filter-lang" data-kind="languages">
	<div class="dropdown-header"><b>LANGUAGE</b></div>
	<a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="r"> <i class="fab fa-r-project"></i> R </label></a>
	<a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="python"> <i class="fab fa-python"></i> Python </label></a>
		<a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="julia"> <i class="icon-julialang-icon"><i class="path1"></i><i class="path2"></i><i class="path3"></i></i> Julia </label></a>
			<a class="dropdown-item"><label><input type="checkbox" class="form-check-input" name="sql"> <i class="icon-file-sql"></i> SQL </label></a>
	</div>
	</div>
	<button class="btn btn-info" id="do-filter">Go!</button>
  </div>
</div>

<br/>
<!-- post generate -->
  <div class="row" id="dm-post"></div>
  <button type="button" class="btn gradient-button text-white rounded-pill" id="dm-more-btn">MORE</button>

</section>

```
