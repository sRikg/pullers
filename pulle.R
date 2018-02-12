require(rvest)

df_list <- list()
temp <- unique(tracks$Album_Identifier)
for(i in 1:length(temp)) {
df_list[[i]] <- read_html(temp[i])
print(i)
}

data_list <- lapply(
    1:length(df_list),
    function(i)
        as.character(html_nodes(
            df_list[[i]],
            xpath = "//body//section//div//div//div//ul//li//div//span//a"
        ))
)

c(254, 297, 298, 299, 300, 301, 429)

for(i in 430:length(data_list)){
    data_list[[i]] <- data_list[[i]][1:(length(data_list[[i]]) - 2)]
}
636, 474
track_list <- list()
for(j in 1:length(data_list)){
    track_list[[j]] <- sapply(
        1:length(data_list[[j]]),
        function(i) unique(unlist(strsplit(
            data_list[[j]][i],
            split = "       "
        )))[4]
    )
    print(j)
}

for(i in 1:length(data_list)){
    track_list[[i]] <- track_list[[i]][!is.na(track_list[[i]])]
}

tracklist <- list()
for(i in c(1:253, 255:296, 302:428, 430:length(track_list))){
    tracklist[[i]] <- sapply(
        1:length(track_list[[i]]),
        function(k) unlist(strsplit(
           track_list[[i]][k],
           split = "\\. "))[2]
    )
}

for(i in c(1:253, 255:296, 302:428, 430:length(track_list))){
    tracklist[[i]] <- sapply(
        1:length(track_list[[i]]), 
        function(k) unlist(strsplit(
            track_list[[i]][k], 
            split = " \\( "
        ))
    )
}

#474
for(i in c(1:253, 255:296, 302:428, 430:length(track_list))){
    tracklist[[i]][2,] <- sapply(
        1:ncol(tracklist[[i]]),
        function(k) unlist(strsplit(tracklist[[i]][2,k], split = " \\)"))
    )
}

for(i in c(1:253, 255:296, 302:428, 430:length(track_list))) {
    tracklist[[i]] <- t(tracklist[[i]])
}

for(j in c(1:253, 255:296, 302:428, 430:length(track_list))){
    tracklist[[j]][,1] <- sapply(
        1:nrow(tracklist[[j]]),
        function(i) unlist(strsplit(
            tracklist[[j]][i,1],
            split = "[0-9]\\. "
        ))[2]
     )
}

