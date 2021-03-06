p_load(httr, jsonlite, dplyr)
myurl <- "https://corona.lmao.ninja/v2/jhucsse"
my_data <- GET(myurl)
##str(my_data$content)
my_content <- content(my_data, as = 'text')
json_form <- fromJSON(my_content)
 dmap_loc <- tibble(location = c(json_form$county,json_form$province))
 json_form["color"] <- tibble(color = c(ifelse((json_form$stats$confirmed-(json_form$stats$deaths+json_form$stats$recovered))<500,"green",ifelse((json_form$stats$confirmed-(json_form$stats$deaths+json_form$stats$recovered))<1000,"orange","red"))))
  json_form["size"] <- tibble(color = c(ifelse((json_form$stats$confirmed-(json_form$stats$deaths+json_form$stats$recovered))<500,5,ifelse((json_form$stats$confirmed-(json_form$stats$deaths+json_form$stats$recovered))<1000,10,15))))  

  leaflet() %>%
     addTiles() %>%
addCircleMarkers(data = json_form, lat =  as.numeric(json_form$coordinates$latitude), lng = as.numeric(json_form$coordinates$longitude), color = json_form$color, radius  = as.numeric(json_form$size))
   
 