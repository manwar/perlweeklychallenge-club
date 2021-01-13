library(splus2R) # peaks

(arr <- sample (c(1:50), size=10, replace=F))

arr[c(ifelse(which(peaks(c(0, head(arr,2)), span=3, strict=T)),1), 
    which(peaks(arr, span=3, strict=T)),
    ifelse(which(peaks(c(head(arr,2), 0), span=3, strict=T)),length(arr)))]