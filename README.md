
# cbbdr

<!-- badges: start -->
<!-- badges: end -->

`cbbdr` allows you to pull in college basketball data quickly from the CollegeBasketballData.com (CBBD) API.

## Installation

You can install the development version of `cbbdr` from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("cfbd/cbbd-r")
```

## Authentication

Accessing the collegebasketballdata.com API in any form, including this package, requires a free API key. API usage is limited to 1,000 free API calls per month, though more are accessible by subscribing to the [CollegeFootballData.com Patreon](https://www.patreon.com/collegefootballdata/membership). 

To obtain a free API key, go to https://collegebasketballdata.com/key and sign up with your email address. You should receive an API key shortly.

To use the API key to access data with cbbdr, use `set_api_key()`. API keys are stored using the [keyring](https://keyring.r-lib.org/) R package, and will securely persist across R sessions.

```r
library(cbbdr)
set_api_key()
```

## Accessing Data

This package allows you access any CBBD API endpoint. For example, you can get a dataframe of all games taking place on a single day with the following code:

```r
cbbdr::get_games(start_date_range = "2024-12-01",
                 end_date_range = "2024-12-01") |> 
    tibble::tibble()
#> # A tibble: 10 × 35
#>       id source_id season_label season season_type tournament start_date        
#>    <int> <chr>     <chr>         <int> <chr>       <lgl>      <chr>             
#>  1  1476 401715612 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  2  1477 401730559 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  3  1523 401722412 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  4  1524 401722152 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  5  1526 401721071 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  6  1527 401721024 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  7  1528 401720669 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  8  1529 401716023 20242025       2025 regular     NA         2024-12-01T00:00:…
#>  9  1530 401714902 20242025       2025 regular     NA         2024-12-01T00:00:…
#> 10  1525 401721812 20242025       2025 regular     NA         2024-12-01T00:00:…
#> # ℹ 28 more variables: start_time_tbd <lgl>, neutral_site <lgl>,
#> #   conference_game <lgl>, game_type <chr>, status <chr>, game_notes <chr>,
#> #   attendance <int>, home_team_id <int>, home_team <chr>,
#> #   home_conference_id <int>, home_conference <chr>, home_seed <lgl>,
#> #   home_points <int>, home_period_points <list>, home_winner <lgl>,
#> #   away_team_id <int>, away_team <chr>, away_conference_id <int>,
#> #   away_conference <chr>, away_seed <lgl>, away_points <int>, …
```

You can also provide different arguments (as you would to the endpoint). For example, the same function can be used to obtain the games for a speciifc team for a season:

```r
cbbdr::get_games(
  team = "Georgia Tech",
  season = 2025
) |>
  tibble::tibble()
#> # A tibble: 34 × 35
#>       id source_id season_label season season_type tournament start_date        
#>    <int> <chr>     <chr>         <int> <chr>       <chr>      <chr>             
#>  1   241 401715667 20242025       2025 regular     <NA>       2024-11-07T00:30:…
#>  2   446 401711744 20242025       2025 regular     <NA>       2024-11-10T18:00:…
#>  3   558 401715668 20242025       2025 regular     <NA>       2024-11-13T00:30:…
#>  4   712 401714898 20242025       2025 regular     <NA>       2024-11-16T01:00:…
#>  5  1099 401715631 20242025       2025 regular     <NA>       2024-11-23T19:00:…
#>  6  1386 401715669 20242025       2025 regular     <NA>       2024-11-28T00:30:…
#>  7  1488 401715670 20242025       2025 regular     <NA>       2024-11-30T18:00:…
#>  8  1597 401715671 20242025       2025 regular     <NA>       2024-12-04T02:00:…
#>  9  1768 401724770 20242025       2025 regular     <NA>       2024-12-07T19:00:…
#> 10  2129 401715403 20242025       2025 regular     <NA>       2024-12-15T21:00:…
#> # ℹ 24 more rows
#> # ℹ 28 more variables: start_time_tbd <lgl>, neutral_site <lgl>,
#> #   conference_game <lgl>, game_type <chr>, status <chr>, game_notes <chr>,
#> #   attendance <int>, home_team_id <int>, home_team <chr>,
#> #   home_conference_id <int>, home_conference <chr>, home_seed <lgl>,
#> #   home_points <int>, home_period_points <list>, home_winner <lgl>,
#> #   away_team_id <int>, away_team <chr>, away_conference_id <int>, …
```

Some functions do not require any parameters.

```r
cbbdr::get_venues() |>
  tibble::tibble()
#> # A tibble: 979 × 6
#>       id source_id name                                      city  state country
#>    <int> <chr>     <chr>                                     <chr> <chr> <chr>  
#>  1  1237 2292      Cancha Del Atletico                       Tucu… <NA>  Argent…
#>  2  1258 2566      St. George's High School                  Free… <NA>  <NA>   
#>  3  1621 6289      CARSA Performance Gym                     Vict… BC    Canada 
#>  4  1500 5287      Youth Arena                               Rio … <NA>  Brazil 
#>  5  1501 5288      Carioca Arena 1                           Rio … <NA>  Brazil 
#>  6  1290 3155      Jeunesse Arena                            Rio … <NA>  Brazil 
#>  7  1613 6276      Wuhan Sports Center                       Hebei <NA>  China  
#>  8  1359 4010      Cadillac Arena                            Beij… <NA>  China  
#>  9  1474 5073      Shenzhen Dayun Arena                      Shen… <NA>  China  
#> 10  1612 6275      Foshan International Sports & Cultural A… Guan… <NA>  China  
#> # ℹ 969 more rows
```
