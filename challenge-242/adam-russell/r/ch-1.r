ch_1 <- function(){
    structure(list(), class = "ch_1")
}

missing_members <- function(self, l1, l2){
    UseMethod("missing_members", self)
}

missing_members.ch_1 <- function(self, l1, l2){
    r <- rbind(unique(l1[!(l1 %in% l2)]), unique(l2[!(l2 %in% l1)]))
    return(r)
}

ch_1 <- ch_1()
missing <- missing_members(ch_1, c(1, 2, 3), c(2, 4, 6))
print(missing)
missing <- missing_members(ch_1, c(1, 2, 3, 3), c(1, 1, 2, 2))
print(missing)