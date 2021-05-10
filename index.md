---
output: github_document
---
# <span class="drac-pink">DataMotto</span> <a href='https://datamotto.com'><img src='assets/img/hex-logo.png' target="_blank" align="right" height="138" /></a>

<!-- README.md is generated from README.Rmd. Please edit that file -->



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

.copyright img {
  display: none;
}
</style>

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

DataMotto is a data science educational website formatted as an <span class="drac-orange">R-pkg</span>, where users can learn, build, and share multilingual data skills efficiently. Putting <span class="drac-orange">minimality</span> as the heart of DataMotto’s philosophy, we aim to build high-quality data resources in a conventional format called <span class="drac-pink">Dotto</span>. The Dottos are developed based on the best practice coding and state-of-the-art packages to efficiently solve a data science problem. For each of Dotto’s problems, we develop the solutions in different popular programming languages that everyone can enjoy no matter what language they are comfortable with. The core languages we cover <span class="drac-cyan">R</span>, <span class="drac-cyan">Python</span>, <span class="drac-cyan">Julia</span>, <span class="drac-cyan">SQL</span>, and <span class="drac-cyan">nodeJS</span>.

## DataMotto <span class="drac-green">Structure</span>

<center class="h2 drac-green"> `Dot` > `Dotto` > `Line` > `Space` </center>

### Dotto: <img src="assets/img/red-circle.svg" width=3.5%"/>
Dottos are the critical elements of DataMotto that aims to create <span class="drac-orange">dynamic modularized</span> data science educational materials. They are self-explanatory, autonomous, <span class="drac-pink">multilingual</span> data resources designed to be right to the point and solve a problem concisely. To clarify more, everyone can think of Dotto as a high-quality summary of an online course, an overview of a book chapter, a review of a package or group of packages, a technical summary of a paper, a real-world case study, Interview preparation materials, and many other scenarios.

### Dot: <img src="assets/img/dotto-to-dots.svg" width=7%"/>

Dottos are composed of Dots, which are the smallest component of DataMotto. All Dots has three parts: Instruction, Code, and Result. Our conventional framework has some rules for creating Dots:

1. The <span class="drac-pink">Instruction</span> part has a limit of 560 characters. They introduce briefly the problem, instruction, or other resources you may need to check

1. The <span class="drac-pink">Code</span> part has a limit of 15 lines, including comments.

1. The <span class="drac-pink">Result</span> part includes only one table, figure, or list. You may see an interpretation of the results here as well (up to 280 characters).


### Line: <img src="assets/img/red-line-chart.svg" width=9%"/>

Considering DataMotto as a modularized platform with having Dottos as the building blocks, Dottos can team up, be connected together and create a <span class="drac-pink">Line</span> that can cover a comprehensive concept in data science efficiently. As each line is created from (multilingual) Dottos, they are covering different programming language. Lines can be considered as a dynamic educational materials that their length may be altered in the future.

### Creating a Dotto

To create a Dotto, please check [this article](./articles/Creating_Dotto.html) that explains the technical structure of a Dotto and the process of creating a new Dotto or adding a new language to an existing Dotto.

## 🧨 Do you have an idea for a Dotto?

If you have a proposal for creating a new <span class="drac-pink">Dotto</span>, you should fill out a [<span class="drac-yellow">Dotto request</span>](https://github.com/DataMotto/DataMotto/issues/new?assignees=ardeeshany&labels=Dotto+Request&template=dotto-request.md&title=). Then, we review your request, create a branch for you, and help you to build your Dotto and publish it on the [DataMotto](https://DataMotto.com) website.

## 🏎 Do you want to add a new language to an existing Dotto?

If you are willing to add a new <span class="drac-green">language</span> to an existing Dotto, you should fill out a [<span class="drac-yellow">Language request</span>](https://github.com/DataMotto/DataMotto/issues/new?assignees=&labels=Lang+Request&template=language-request.md&title=). Then, we review your request, get you to connect with the primary author(s), create a branch for you, and help you to upgrade the Dotto and update [DataMotto](https://DataMotto.com) website.
