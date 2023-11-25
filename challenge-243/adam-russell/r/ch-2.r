ch_2 <- function(){
    structure(list(), class = "ch_2")
}

floor_sum <- function(self, l){
    UseMethod("floor_sum", self)
}

floor_sum <- function(self, integers) {
  floor_sum <- 0
  for (x in integers) {
    for (y in integers) {
      floor_sum <- floor_sum + floor(x / y)
    }
  }
  return(floor_sum)
}

ch_2 <- ch_2()
floor_summed <- floor_sum(ch_1, c(2, 5, 9))
print(floor_summed)
floor_summed <- floor_sum(ch_1, c(7, 7, 7, 7, 7, 7, 7))
print(floor_summed)