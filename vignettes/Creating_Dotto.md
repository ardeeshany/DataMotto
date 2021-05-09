
<style type="text/css">
body {
  background-color: #282a36;
  color: white;
  font-size: 18px;
}
.drac-pink {
  color: #ff79c6;
}

.drac-green {
  color: #50fa7b;
}

.drac-orange {
  color: #ffb86c;
}

.drac-cyan {
  color: #8be9fd;
}

.drac-yellow {
  color: #f1fa8c;
}

.dotto-dot-code {
  background-color: #f1faf0;
  font-size: 13px;
  border: 0px;
}

.verbatim-codes pre {
  background-color: #f1faf0;
  font-size: 14px;
  border: 0px;
}
</style>

## Creating a <span class="drac-pink">Dotto</span>

To create a new Dotto and add it into the
[DataMotto](https://datamotto.com), first, you should clone the project
and run the package locally by

``` r
devtools::load_all()
```

Then you can create your Dotto from the command line with:

``` r
create_Dotto(title = "Your Title", lang = "r")
```

It creates a Dotto folder under `posts/Dotto/` path with an Rmd
template, which uses a `DataMotto::Dotto` as its output format and
includes title, description, author, tech, date, categories,
applications, cover\_image, and slug in its YAML front-matter:

``` r
---
title: "Your Title"
description: |
  A short description of the Dotto.
author:
  - name: "First Last"
    occupation: NULL
    affiliation: NULL
    url: NULL
    img: NULL
    lang: r
tech:
  - lang: r
    pkgs: NULL
date:
  created: "2021-05-08"
  last_updated: "2021-05-08"
categories: NULL
applications: NULL
cover_image: NULL
slug: "your-title"
output: DataMotto::Dotto
---
```

For the author field, the <span class="drac-cyan">lang</span> specifies
each <span class="drac-cyan">author</span> contributed to what
programming language part of the Dotto. The <span
class="drac-cyan">tech</span> field shows how many languages are being
covered in the Dotto and for each language, what are the key
packages/libraries are used. To mention more than one package name,
everyone can use the `pkgs: ["pkg1", "pkg2", ...]` format. For adding
one more language, duplicate the lang and pkgs fields as follows:

``` r
tech:
  - lang: r
    pkgs: ["ggplot2", "dplyr"]
  - lang: python
    pkgs: ["pands"]
```

The <span class="drac-cyan">cover\_image</span> field is one of the
images created by the Dotto, located under
\`\*\_files/figure-html/your\_favorite\_img.png", or an external link
that will be shown in the social network sharing card.

The <span class="drac-cyan">slug</span> is created automatically from
the title, and we suggest you not change it manually. In case you want
to change, you only need to change your working directory into the Dotto
folder, change the title and run:

``` r
DataMotto::update_Dotto()
```

In the bottom of the YAML, we have a `use_Dotto()` helper function that
set-up the Dotto functionalities and styles the output page. Do not
remove this code!

<div class="verbatim-codes">

```` r
```{r DataMotto, eval=F}
DataMotto::use_Dotto()
```
````

</div>

Then we can focus on completing each Dots. The <span
class="drac-cyan">Dot</span> and <span class="drac-cyan">part</span>
parameters select what Dot and which part of the Dot we are working on.

<div class="verbatim-codes">

```` r
<!-- Dot 1, lang: r ------------------------------------------------>

```{block, Dot = 1, part = "Instruction", lang = "r"}

```

```{r, Dot = 1, part = "Code", echo = T, eval = F}

```

```{r, Dot = 1, part = "Result", echo = F, eval = T}

```
````

</div>

### Adding a <span class="drac-green">new Dot</span>:

For adding a new Dot, e.g., the second one, you only need to duplicate
the whole Dot template and change the <span class="drac-yellow"> Dot = 2
</span> as follows:

<div class="verbatim-codes">

    <!-- Dot 1, lang: r ------------------------------------------------>

    ```{block, Dot = 1, part = "Instruction", lang = "r"}

    ```

    ```{r, Dot = 1, part = "Code", echo = T, eval = F}

    ```

    ```{r, Dot = 1, part = "Result", echo = F, eval = T}

    ```
    <!-- Dot 2, lang: r ------------------------------------------------>

    ```{block, Dot = 2, part = "Instruction", lang = "r"}

    ```

    ```{r, Dot = 2, part = "Code", echo = T, eval = F}

    ```

    ```{r, Dot = 2, part = "Result", echo = F, eval = T}

    ```

</span>

## Adding a <span class="drac-green">new language</span> to an existing Dotto

For adding a new language, you should duplicate each chunk and change
the engine and code scripts and keep the new chunk close to the old one.
For example, for adding Python and Julia, we should write:
<div class="verbatim-codes">

    <!-- Dot 1, lang: r, python ------------------------------------------------>

    ```{block, Dot = 1, part = "Instruction", lang = "r"}

    ```
    ```{block, Dot = 1, part = "Instruction", lang = "python"}

    ```

    ```{r, Dot = 1, part = "Code", echo = T, eval = F}

    ```
    ```{python, Dot = 1, part = "Code", echo = T, eval = F}

    ```

    ```{r, Dot = 1, part = "Result", echo = F, eval = T}

    ```
    ```{python, Dot = 1, part = "Result", echo = F, eval = T}

    ```

</span>
