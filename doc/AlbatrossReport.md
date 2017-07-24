Albatross Travel Patterns
================
Srirama Bhamidipati
20 July 2017

Summary
-------

#### Questions

1.  How many modes of travel are reported in Albatross?
2.  How many activities are registered in Albatross?
3.  Which modes are used for travel to work?
4.  How far do people travel to work?
5.  How does travel pattern look on weekends?
6.  How does the (work) travel pattern look on weekdays?
7.  Extracting work pattern on weekdays.
8.  Extracting (car) work pattern on weekdays.
9.  Extracting travel pattern on weekends.
10. Extracting (car) travel pattern on weekends.

#### 1. How many and which modes?

    ## [1] "car"              "car passenger"    "slow mode"       
    ## [4] "public transport"

#### 2. How many and which activities?

    ##  [1] "Work"                             "Business"                        
    ##  [3] "Bring and Get"                    "Daily Shopping"                  
    ##  [5] "NonDaily Shopping"                "Services (bank, postOffice etc) "
    ##  [7] "Social"                           "Leisure"                         
    ##  [9] "Tour"                             "Home"

#### 3. Which modes are used for travel to work?

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

#### 4. How far do people travel to work?

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

#### 5. How does the travel pattern look on weekends?

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

#### 6. How does the ((work)) travel pattern look on weekdays ?

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

<!-- #### 6. How does travel pattern differ by gender? -->
<!-- ```{r} -->
<!-- ggplot(data=monCleaned_Distance[monCleaned_Distance$Atype=="Work" & monCleaned_Distance$Day <=5,], aes(x=TravDist, fill=factor(Gend), colour=factor(Gend))) +  -->
<!--   geom_line(stat = "density")+ -->
<!--   #geom_histogram()+ -->
<!--  # geom_freqpoly(data=monCleaned_Distance[monCleaned_Distance$Atype=="Work" & monCleaned_Distance$Day <=5 & monCleaned_Distance$Gend==0,], binwidth = 5) + -->
<!--   #geom_line(data=monCleaned_Distance[monCleaned_Distance$Atype=="Work" & monCleaned_Distance$Day <=5 & monCleaned_Distance$Gend==0,],stat = "density", colour="blue", alpha=0.2) + -->
<!--  # geom_line(data=monCleaned_Distance[monCleaned_Distance$Atype=="Work" & monCleaned_Distance$Day <=5 & monCleaned_Distance$Gend==1,],stat = "density", colour="red", alpha=0.2) + -->
<!--   #geom_density(colour=NA, fill="blue", alpha=0.2)+  -->
<!--   facet_wrap(~Mode, ncol = 2, scales = "free_y") +  -->
<!--   xlab("Distance in km") +  xlim(0,200)  -->
<!-- ``` -->
#### 7. Extracting work pattern on weekdays

For control over what distance ranges are extracted from the MON data, we define our own distance bins.

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

#### 8. Extracting (car) work pattern on weekdays

For control over what distance ranges are extracted from the MON data, we define our own distance bins.

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

#### 9. Extracting travel pattern on weekends

For control over what distance ranges are extracted from the MON data, we define our own distance bins.

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

#### 10. Extracting (car) travel pattern on weekends

For control over what distance ranges are extracted from the MON data, we define our own distance bins.

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

Cleaning Data
-------------

It was found that the data has some problems interms of Travel Distance not matching with Travel Time. For example, some people could reach 500km in 5 minutes. This does not make sense. After careful deliberation, it was decided to discard all households where the Travel Distance atrribute is 500.

#### Cleaned : Travel Distance vs Travel Time - All modes - All purposes - Weekdays

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

#### Cleaned : Travel Distance vs Travel Time - car - All purposes - weekdays

<img src="AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png" width="100%" />

#### Cleaned : Travel Distance vs Travel Time - car - All purposes - weekends

<img src="AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png" width="100%" />

#### Cleaned : Travel Distance vs Travel Time - car -(weekdays)- *Work*

<img src="AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png" style="display: block; margin: auto;" />

#### Cleaned : Travel Distance vs Travel Time - car (weekdays) - *Social*

<img src="AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-18-1.png" style="display: block; margin: auto;" />

#### Cleaned : Travel Distance vs Travel Time - car (weekends) - *Social*

<img src="AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-19-1.png" style="display: block; margin: auto;" />

#### Cleaned : Extracting Travel Patterns for work on weekdays - car

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-20-1.png)

#### Cleaned : Extracting Travel Patterns on weekends - car

![](AlbatrossReport_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-21-1.png)
