---
title: "Finland"
description: |
  The World Happiness dataset contains six factors to measure global happiness: life expectancy, economics, social support, absence of corruption, freedom, and generosity. These factors were reported for 166 countries around the world from 2005 to 2020. In this Dotto, we want to find the top five happiest countries then plot the happiness rate for these countries from 2015 to 2019.
  
author:
  - name: "Mahyar Sharifi"
    occupation: Internship
    affiliation: DataMotto
    url: NULL
    img: NULL
    lang: r
tech:
  - lang: r
    pkgs: dplyer, ggplot2
date:
  created: "2021-06-29"
  last_updated: "2021-06-29"
categories: Storyteller
applications: Governance
cover_image: NULL
slug: "finland"
output: DataMotto::Dotto
---


```{=html}

<section v-if="activeDotto === '1'"
class="text-left d-flex flex-row flex-grow-1 flex-wrap" id="dotto-row-main">
<div class="col-12 col-lg-1" id="dotto-main-dots">

<button type="button" @click="activeMotto = '1'"
class="btn dotto-main-dot-shape"
:class="{'btn-light': activeMotto === '1', 'btn-outline-light': activeMotto !== '1'}">1</button>


<button type="button" @click="activeMotto = '2'"
class="btn dotto-main-dot-shape"
:class="{'btn-light': activeMotto === '2', 'btn-outline-light': activeMotto !== '2'}">2</button>


<button type="button" @click="activeMotto = '3'"
class="btn dotto-main-dot-shape"
:class="{'btn-light': activeMotto === '3', 'btn-outline-light': activeMotto !== '3'}">3</button>


<button type="button" @click="activeMotto = '4'"
class="btn dotto-main-dot-shape"
:class="{'btn-light': activeMotto === '4', 'btn-outline-light': activeMotto !== '4'}">4</button>

</div>

```

<!-- Dot 1, lang: r ------------------------------------------------>


```{=html}

<div v-if="activeMotto === '1'" class="col-12 col-lg-11 d-flex p-0 wrapper">
<div class="box overflow-auto dotto-main-intro dotto-dot-instruction">
<div class="card-header">
<h1>&nbsp;Instructions:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2">
<p class="mx-2">

```
In the first DOT, we import two packages: pandas: importing and wrangling dataset seaborn: plotting a line-plot Then we import the World Happiness dataset and select rows for 2015 to 2019 for all countries.

```{=html}

</p>
</div>
 

```


```{=html}

</div>
<div class="handler dotto-main-intro"></div>
<div id="resizable">
<div class="box2 dotto-main overflow-auto dotto-main-codes">
<div class="card-header dot-codes">
<h1>&nbsp;Codes:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2">

```

```{.r .dotto-dot-code}
#load library
library(dplyr)
library(ggplot2)

#read world happiness dataset
data <- read.csv('D:/world-happiness-report.csv', fileEncoding="UTF-8-BOM")
head(data)
```

```
##   Country.name year Life.Ladder Log.GDP.per.capita Social.support
## 1  Afghanistan 2008       3.724              7.370          0.451
## 2  Afghanistan 2009       4.402              7.540          0.552
## 3  Afghanistan 2010       4.758              7.647          0.539
## 4  Afghanistan 2011       3.832              7.620          0.521
## 5  Afghanistan 2012       3.783              7.705          0.521
## 6  Afghanistan 2013       3.572              7.725          0.484
##   Healthy.life.expectancy.at.birth Freedom.to.make.life.choices Generosity
## 1                            50.80                        0.718      0.168
## 2                            51.20                        0.679      0.190
## 3                            51.60                        0.600      0.121
## 4                            51.92                        0.496      0.162
## 5                            52.24                        0.531      0.236
## 6                            52.56                        0.578      0.061
##   Perceptions.of.corruption Positive.affect Negative.affect
## 1                     0.882           0.518           0.258
## 2                     0.850           0.584           0.237
## 3                     0.707           0.618           0.275
## 4                     0.731           0.611           0.267
## 5                     0.776           0.710           0.268
## 6                     0.823           0.621           0.273
```

```{.r .dotto-dot-code}
# Select Dataset from 2015-2019
data <- filter(data,year %in% c(2015:2019))
```

```{=html}

</div>
 

```


```{=html}

</div>
<div class="handler2 dotto-main-output"></div>
<div class="box2 dotto-main overflow-auto dotto-main-output">
<div class="card-header">
<h1>&nbsp;Results:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2 dotto-dot-output">

```

```
##   Country.name year Life.Ladder Log.GDP.per.capita Social.support
## 1  Afghanistan 2008       3.724              7.370          0.451
## 2  Afghanistan 2009       4.402              7.540          0.552
## 3  Afghanistan 2010       4.758              7.647          0.539
## 4  Afghanistan 2011       3.832              7.620          0.521
## 5  Afghanistan 2012       3.783              7.705          0.521
## 6  Afghanistan 2013       3.572              7.725          0.484
##   Healthy.life.expectancy.at.birth Freedom.to.make.life.choices Generosity
## 1                            50.80                        0.718      0.168
## 2                            51.20                        0.679      0.190
## 3                            51.60                        0.600      0.121
## 4                            51.92                        0.496      0.162
## 5                            52.24                        0.531      0.236
## 6                            52.56                        0.578      0.061
##   Perceptions.of.corruption Positive.affect Negative.affect
## 1                     0.882           0.518           0.258
## 2                     0.850           0.584           0.237
## 3                     0.707           0.618           0.275
## 4                     0.731           0.611           0.267
## 5                     0.776           0.710           0.268
## 6                     0.823           0.621           0.273
```

```{=html}

</div>
 
</div>
</div>
</div>

```


```{=html}

 
<div v-if="activeLang === 'python'" class="mx-2">

```

```{.python .dotto-dot-code}
#Import Packages
import pandas as pd
import seaborn as sns

#read world happiness dataset
data = pd.read_csv('D:/world-happiness-report.csv')
data.shape

# Select Dataset from 2015-2019
```

```
## (1949, 11)
```

```{.python .dotto-dot-code}
data = data[data['year'].isin(range(2015,2020))]
```

```{=html}

</div>
 

```


```{=html}

 
<div v-if="activeLang === 'python'" class="mx-2 dotto-dot-output">

```

```
## (1949, 11)
```

```{=html}

</div>
 

```


```{=html}

<div v-if="activeMotto === '2'" class="col-12 col-lg-11 d-flex p-0 wrapper">
<div class="box overflow-auto dotto-main-intro dotto-dot-instruction">
<div class="card-header">
<h1>&nbsp;Instructions:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2">
<p class="mx-2">

```
After we select the dataset, the average of Life Ladder calculates for each country. Then the top five happiest countries will be identified by sorting the dataset by Life Ladder columns.

```{=html}

</p>
</div>
 

```


```{=html}

</div>
<div class="handler dotto-main-intro"></div>
<div id="resizable">
<div class="box2 dotto-main overflow-auto dotto-main-codes">
<div class="card-header dot-codes">
<h1>&nbsp;Codes:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2">

```

```{.r .dotto-dot-code}
# Grouping Data by Country
data_grouped_country <- group_by(data, Country.name)
data_grouped_country <- summarise(data_grouped_country, Mean.Life.Ladder = mean(Life.Ladder))

# Sort the New data_grouped_country by Life Ladder column
happiest_country <- arrange(data_grouped_country, desc(Mean.Life.Ladder))
head(happiest_country, 8)
```

```
## # A tibble: 8 x 2
##   Country.name Mean.Life.Ladder
##   <chr>                   <dbl>
## 1 Finland                  7.71
## 2 Denmark                  7.60
## 3 Switzerland              7.54
## 4 Norway                   7.53
## 5 Iceland                  7.50
## 6 Netherlands              7.44
## 7 Sweden                   7.34
## 8 New Zealand              7.31
```

```{.r .dotto-dot-code}
#Identify and select five-top country
as.vector(t(happiest_country[1:5,1]))
```

```
## [1] "Finland"     "Denmark"     "Switzerland" "Norway"      "Iceland"
```

```{=html}

</div>
 

```


```{=html}

</div>
<div class="handler2 dotto-main-output"></div>
<div class="box2 dotto-main overflow-auto dotto-main-output">
<div class="card-header">
<h1>&nbsp;Results:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2 dotto-dot-output">

```

```
## # A tibble: 8 x 2
##   Country.name Mean.Life.Ladder
##   <chr>                   <dbl>
## 1 Finland                  7.71
## 2 Denmark                  7.60
## 3 Switzerland              7.54
## 4 Norway                   7.53
## 5 Iceland                  7.50
## 6 Netherlands              7.44
## 7 Sweden                   7.34
## 8 New Zealand              7.31
```

```
## [1] "Finland"     "Denmark"     "Switzerland" "Norway"      "Iceland"
```

```{=html}

</div>
 
</div>
</div>
</div>

```


```{=html}

 
<div v-if="activeLang === 'python'" class="mx-2">

```

```{.python .dotto-dot-code}
#Calculate Mean of Life Ladder for Each Country during 2015-2019
data_grouped = data.groupby('Country name').mean()
data_grouped

#Sort data_grouped by Life Ladder Column
```

```
##                 year  Life Ladder  ...  Positive affect  Negative affect
## Country name                       ...                                  
## Afghanistan   2017.0       3.1868  ...          0.47800           0.3930
## Albania       2017.0       4.7514  ...          0.68520           0.3198
## Algeria       2017.5       5.0945  ...          0.61975           0.2935
## Argentina     2017.0       6.2084  ...          0.83120           0.3098
## Armenia       2017.0       4.7022  ...          0.59840           0.4394
## ...              ...          ...  ...              ...              ...
## Venezuela     2017.0       4.9536  ...          0.76020           0.3406
## Vietnam       2017.0       5.2152  ...          0.65525           0.2080
## Yemen         2017.0       3.4636  ...          0.48700           0.2744
## Zambia        2017.0       4.0944  ...          0.71040           0.3772
## Zimbabwe      2017.0       3.4772  ...          0.73700           0.2118
## 
## [157 rows x 10 columns]
```

```{.python .dotto-dot-code}
sorted_data = data_grouped.sort_values(['Life Ladder'],
          ascending = False)
```

```{=html}

</div>
 

```


```{=html}

 
<div v-if="activeLang === 'python'" class="mx-2 dotto-dot-output">

```

```
##                 year  Life Ladder  ...  Positive affect  Negative affect
## Country name                       ...                                  
## Afghanistan   2017.0       3.1868  ...          0.47800           0.3930
## Albania       2017.0       4.7514  ...          0.68520           0.3198
## Algeria       2017.5       5.0945  ...          0.61975           0.2935
## Argentina     2017.0       6.2084  ...          0.83120           0.3098
## Armenia       2017.0       4.7022  ...          0.59840           0.4394
## ...              ...          ...  ...              ...              ...
## Venezuela     2017.0       4.9536  ...          0.76020           0.3406
## Vietnam       2017.0       5.2152  ...          0.65525           0.2080
## Yemen         2017.0       3.4636  ...          0.48700           0.2744
## Zambia        2017.0       4.0944  ...          0.71040           0.3772
## Zimbabwe      2017.0       3.4772  ...          0.73700           0.2118
## 
## [157 rows x 10 columns]
```

```{=html}

</div>
 

```


```{=html}

<div v-if="activeMotto === '3'" class="col-12 col-lg-11 d-flex p-0 wrapper">
<div class="box overflow-auto dotto-main-intro dotto-dot-instruction">
<div class="card-header">
<h1>&nbsp;Instructions:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2">
<p class="mx-2">

```
Finland, Denmark, Switzerland, Norway, and Iceland were identified as the happiest country in a row from 2015 to 2019. In this Dot, the new dataset will create for these countries which name is "top-five". As we can see in the top-five dataset, Iceland has no information for 2018.

```{=html}

</p>
</div>
 

```


```{=html}

</div>
<div class="handler dotto-main-intro"></div>
<div id="resizable">
<div class="box2 dotto-main overflow-auto dotto-main-codes">
<div class="card-header dot-codes">
<h1>&nbsp;Codes:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2">

```

```{.r .dotto-dot-code}
# Select New Dataset for the Top-five Happiest Country
data_top_five = filter(data, Country.name %in% 
                         as.vector(t(happiest_country[1:5,1])))
head(data_top_five, 50)
```

```
##    Country.name year Life.Ladder Log.GDP.per.capita Social.support
## 1       Denmark 2015       7.514             10.878          0.960
## 2       Denmark 2016       7.558             10.903          0.954
## 3       Denmark 2017       7.594             10.916          0.952
## 4       Denmark 2018       7.649             10.935          0.958
## 5       Denmark 2019       7.693             10.954          0.958
## 6       Finland 2015       7.448             10.716          0.948
## 7       Finland 2016       7.660             10.740          0.954
## 8       Finland 2017       7.788             10.768          0.964
## 9       Finland 2018       7.858             10.783          0.962
## 10      Finland 2019       7.780             10.792          0.937
## 11      Iceland 2015       7.498             10.854          0.980
## 12      Iceland 2016       7.510             10.904          0.985
## 13      Iceland 2017       7.476             10.925          0.967
## 14      Iceland 2019       7.533             10.931          0.982
## 15       Norway 2015       7.603             11.033          0.947
## 16       Norway 2016       7.596             11.035          0.960
## 17       Norway 2017       7.579             11.050          0.950
## 18       Norway 2018       7.444             11.056          0.966
## 19       Norway 2019       7.442             11.061          0.942
## 20  Switzerland 2015       7.572             11.100          0.938
## 21  Switzerland 2016       7.459             11.106          0.928
## 22  Switzerland 2017       7.474             11.115          0.950
## 23  Switzerland 2018       7.509             11.134          0.930
## 24  Switzerland 2019       7.694             11.136          0.949
##    Healthy.life.expectancy.at.birth Freedom.to.make.life.choices Generosity
## 1                              71.5                        0.941      0.222
## 2                              71.8                        0.948      0.138
## 3                              72.1                        0.955      0.155
## 4                              72.4                        0.935      0.018
## 5                              72.7                        0.963      0.020
## 6                              71.6                        0.930      0.111
## 7                              71.7                        0.948     -0.027
## 8                              71.8                        0.962     -0.002
## 9                              71.9                        0.938     -0.127
## 10                             72.0                        0.948     -0.052
## 11                             73.0                        0.940      0.301
## 12                             73.0                        0.952      0.281
## 13                             73.0                        0.939      0.246
## 14                             73.0                        0.959         NA
## 15                             72.9                        0.948      0.257
## 16                             73.0                        0.954      0.133
## 17                             73.1                        0.953      0.236
## 18                             73.2                        0.960      0.094
## 19                             73.3                        0.954      0.111
## 20                             73.2                        0.928      0.109
## 21                             73.5                        0.934      0.088
## 22                             73.8                        0.925      0.180
## 23                             74.1                        0.926      0.101
## 24                             74.4                        0.913      0.036
##    Perceptions.of.corruption Positive.affect Negative.affect
## 1                      0.191           0.829           0.218
## 2                      0.210           0.836           0.208
## 3                      0.181           0.824           0.206
## 4                      0.151           0.821           0.206
## 5                      0.174           0.862           0.181
## 6                      0.223           0.751           0.191
## 7                      0.250           0.797           0.182
## 8                      0.192           0.787           0.176
## 9                      0.199           0.782           0.182
## 10                     0.195           0.755           0.181
## 11                     0.639           0.849           0.180
## 12                     0.719           0.874           0.158
## 13                     0.727           0.895           0.148
## 14                     0.699           0.836           0.178
## 15                     0.299           0.843           0.209
## 16                     0.410           0.850           0.209
## 17                     0.250           0.849           0.203
## 18                     0.268           0.827           0.212
## 19                     0.271           0.823           0.195
## 20                     0.210           0.809           0.166
## 21                     0.302           0.779           0.206
## 22                     0.316           0.774           0.196
## 23                     0.301           0.792           0.192
## 24                     0.294           0.798           0.171
```

```{=html}

</div>
 

```


```{=html}

</div>
<div class="handler2 dotto-main-output"></div>
<div class="box2 dotto-main overflow-auto dotto-main-output">
<div class="card-header">
<h1>&nbsp;Results:</h1>
</div>
<br>
 
<div v-if="activeLang === 'r'" class="mx-2 dotto-dot-output">

```

```
##    Country.name year Life.Ladder Log.GDP.per.capita Social.support
## 1       Denmark 2015       7.514             10.878          0.960
## 2       Denmark 2016       7.558             10.903          0.954
## 3       Denmark 2017       7.594             10.916          0.952
## 4       Denmark 2018       7.649             10.935          0.958
## 5       Denmark 2019       7.693             10.954          0.958
## 6       Finland 2015       7.448             10.716          0.948
## 7       Finland 2016       7.660             10.740          0.954
## 8       Finland 2017       7.788             10.768          0.964
## 9       Finland 2018       7.858             10.783          0.962
## 10      Finland 2019       7.780             10.792          0.937
## 11      Iceland 2015       7.498             10.854          0.980
## 12      Iceland 2016       7.510             10.904          0.985
## 13      Iceland 2017       7.476             10.925          0.967
## 14      Iceland 2019       7.533             10.931          0.982
## 15       Norway 2015       7.603             11.033          0.947
## 16       Norway 2016       7.596             11.035          0.960
## 17       Norway 2017       7.579             11.050          0.950
## 18       Norway 2018       7.444             11.056          0.966
## 19       Norway 2019       7.442             11.061          0.942
## 20  Switzerland 2015       7.572             11.100          0.938
## 21  Switzerland 2016       7.459             11.106          0.928
## 22  Switzerland 2017       7.474             11.115          0.950
## 23  Switzerland 2018       7.509             11.134          0.930
## 24  Switzerland 2019       7.694             11.136          0.949
##    Healthy.life.expectancy.at.birth Freedom.to.make.life.choices Generosity
## 1                              71.5                        0.941      0.222
## 2                              71.8                        0.948      0.138
## 3                              72.1                        0.955      0.155
## 4                              72.4                        0.935      0.018
## 5                              72.7                        0.963      0.020
## 6                              71.6                        0.930      0.111
## 7                              71.7                        0.948     -0.027
## 8                              71.8                        0.962     -0.002
## 9                              71.9                        0.938     -0.127
## 10                             72.0                        0.948     -0.052
## 11                             73.0                        0.940      0.301
## 12                             73.0                        0.952      0.281
## 13                             73.0                        0.939      0.246
## 14                             73.0                        0.959         NA
## 15                             72.9                        0.948      0.257
## 16                             73.0                        0.954      0.133
## 17                             73.1                        0.953      0.236
## 18                             73.2                        0.960      0.094
## 19                             73.3                        0.954      0.111
## 20                             73.2                        0.928      0.109
## 21                             73.5                        0.934      0.088
## 22                             73.8                        0.925      0.180
## 23                             74.1                        0.926      0.101
## 24                             74.4                        0.913      0.036
##    Perceptions.of.corruption Positive.affect Negative.affect
## 1                      0.191           0.829           0.218
## 2                      0.210           0.836           0.208
## 3                      0.181           0.824           0.206
## 4                      0.151           0.821           0.206
## 5                      0.174           0.862           0.181
## 6                      0.223           0.751           0.191
## 7                      0.250           0.797           0.182
## 8                      0.192           0.787           0.176
## 9                      0.199           0.782           0.182
## 10                     0.195           0.755           0.181
## 11                     0.639           0.849           0.180
## 12                     0.719           0.874           0.158
## 13                     0.727           0.895           0.148
## 14                     0.699           0.836           0.178
## 15                     0.299           0.843           0.209
## 16                     0.410           0.850           0.209
## 17                     0.250           0.849           0.203
## 18                     0.268           0.827           0.212
## 19                     0.271           0.823           0.195
## 20                     0.210           0.809           0.166
## 21                     0.302           0.779           0.206
## 22                     0.316           0.774           0.196
## 23                     0.301           0.792           0.192
## 24                     0.294           0.798           0.171
```

```{=html}

</div>
 
</div>
</div>
</div>

```














