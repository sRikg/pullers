require(rvest)
require(googlesheets)

require(googlesheets)

data <- gs_title("Recomally_Data_Collator")
df <- gs_read(data, "Logger")
df <- as.data.frame(df)
df <- df[,c(1:2)]
rm(data)

hh_pages <- list()
hh_pages <- lapply(
  1:nrow(df),
  function(i) read_html(df[i,2])
  )

for(i in 1:nrow(df)){
  hh_pages[[i]] <- read_html(df[i,2])
  print(i)
}

html_nodes(
    hh_pages[[1]], 
    xpath = "//body//div//div//div//div//div//div//div//div//div//div//div//div//div//span//div//span//span//hl//a")

