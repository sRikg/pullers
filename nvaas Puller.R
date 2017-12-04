require(rvest)
#URL of the HTML webpage we want to scrape

lang_runner <- c("hindi, english, tamil, telugu, punjabi, marathi, gujarati, bengali, kannada, bhojpuri, malayalam, urdu, rajasthani, odia, assamese")
lang_runner <- unlist(strsplit(lang_runner, split = ", "))

alpha_runner <- c("catalogue-A, catalogue-B, catalogue-C, catalogue-D, catalogue-E, catalogue-F, catalogue-G, catalogue-H, catalogue-I, catalogue-J, catalogue-K, catalogue-L, catalogue-M, catalogue-N, catalogue-O, catalogue-P, catalogue-Q, catalogue-R, catalogue-S, catalogue-T, catalogue-U, catalogue-V, catalogue-W, catalogue-X, catalogue-Y, catalogue-Z, catalogue-0-9")
alpha_runner <- unlist(strsplit(alpha_runner, split = ", "))

vec <- c()
for(i in 1:length(lang_runner)){
  for(j in 1:length(alpha_runner)){
  vec <- c(vec, paste0(site, alpha_runner[j], "/", lang_runner[i], "/", "albums"))
  }
}

url_catalouge <- vec
rm(vec)

artists_data <- c()
hh_artists <- read_html(url_artists)
catalog_artists <- html_nodes(hh_artists, xpath = "//body//div//div//section//div//div//a")





