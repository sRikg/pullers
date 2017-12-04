require(rvest)
#URL of the HTML webpage we want to scrape

lang_runner <- c("hindi, english, tamil, telugu, punjabi, marathi, gujarati, bengali, kannada, bhojpuri, malayalam, urdu, rajasthani, odia, assamese")
lang_runner <- unlist(strsplit(lang_runner, split = ", "))

alpha_runner <- c("catalogue-A, catalogue-B, catalogue-C, catalogue-D, catalogue-E, catalogue-F, catalogue-G, catalogue-H, catalogue-I, catalogue-J, catalogue-K, catalogue-L, catalogue-M, catalogue-N, catalogue-O, catalogue-P, catalogue-Q, catalogue-R, catalogue-S, catalogue-T, catalogue-U, catalogue-V, catalogue-W, catalogue-X, catalogue-Y, catalogue-Z, catalogue-0-9")
alpha_runner <- unlist(strsplit(alpha_runner, split = ", "))

# remember to add what site is. and add it till ".-browse/"
vec <- c()
for(i in 1:length(lang_runner)){
  for(j in 1:length(alpha_runner)){
  vec <- c(vec, paste0(site, alpha_runner[j], "/", lang_runner[i], "/", "albums"))
  }
}

url_catalouge <- vec
rm(vec)

hh_albums <- list()
for(i in 1:length(url_catalouge)) hh_albums[[i]] <- read_html(url_catalouge[i])
# remove the non existants manually

catalog_artists <- list()
for(i in 1:length(url_catalouge)){
  catalog_artists[[i]] <- as.character(
    html_nodes(
    hh_albums[[i]], 
    xpath = "//body//div//div//section//div//ul//li//a"))
  print(i)}

curator <- function(cell_pair){
  alb_name <- as.character(unlist(strsplit(
    unlist(strsplit(
      cell_pair[1],
      split = ">"))[2],
    split = "<"))[1])
  
  alb_lang <- as.character(unlist(strsplit(cell_pair[1], split = "/"))[6])
  
  alb_year <- as.character(unlist(strsplit(
    unlist(strsplit(
      cell_pair[2],
      split = ">"))[2],
    split = "<"))[1])
  
  alb_url <- as.character(unlist(strsplit(cell_pair[1], split = "\""))[4])
  
 return(c(alb_name, alb_lang, alb_year, alb_url))
}

pre_curator <- function(list, num){
  vec <- list[[num]]
  len <- length(vec)
  startie <- (1:(len/2))*2 - 1
  stopie <- (1:(len/2))*2
  
  worthy <- curator(list[[num]][startie[1]:stopie[1]])
  
  for(i in 2:length(startie)){
    worthy <- rbind(
      worthy, 
      curator(list[[num]][startie[i]:stopie[i]]))}
  
  worthy <- as.data.frame(worthy)
  rownames(worthy) <- as.character(1:nrow(worthy))
  colnames(worthy) <- c("alb_Name", "alb_Lang", "alb_Year", "alb_Link")
  
  return(worthy)
}

df_curated <- pre_curator(catalog_artists, 1)
for(i in 1:395){
  df_curated <- rbind(df_curated, pre_curator(catalog_artists, i))
  print(i)
  }

df_curated <- unique(df_curated)

df_curated <- df_curated[-which(df_curated[,1] == ""),]
df_curated <- df_curated[-876,]

for(i in 1:ncol(df_curated)) df_curated[,i] <- as.character(df_curated[,i])

df_curated[df_curated[,3] == "2104",3] <- "2014"
df_curated[df_curated[,3] == "2114",3] <- "2014"
df_curated <- df_curated[-which(df_curated[,3] %in% c("0012", "0013", "1408561")),]
df_curated <- df_curated[-which(df_curated[,3] %in% c("", "1901", "1905", "1906", "1907", "1922", "1927", "1928")),]

df_curated[,3] <- as.integer(df_curated[,3])
df_curated[,2] <- as.factor(df_curated[,2])

temp <- table(df_curated[,1])
temp <- sort(temp)
temp_multiples <- temp[temp > 1] 

df_reps <- df_curated[df_curated[,1] %in% names(temp_multiples),]
df_albums <- df_curated[!df_curated[,1] %in% names(temp_multiples),]

hh_tracks <- list()
for(i in 1:nrow(df_albums)){
  hh_tracks[[i]] <- read_html(df_albums[i,4])
  print(i)
}



