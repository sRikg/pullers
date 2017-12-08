require(rvest)
require(googlesheets)

require(googlesheets)

data <- gs_title("Recomally_Data_Collator")
df <- gs_read(data, "Logger")
df <- as.data.frame(df)
df <- df[,c(1:2)]
rm(data)

hh_pages <- list()
for(i in 1:length(df)) hh_albums[[i]] <- read_html(url_catalouge[i])
