x <- 5
y <- 1:x
z <- 2

combn(y,z)
# or:
as.data.frame(t(unlist(apply(combn(y,z), 2, list), recursive = FALSE)), row.names = c(""))