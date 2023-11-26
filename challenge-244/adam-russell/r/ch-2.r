ch_2 <- function(){
    structure(list(), class = "ch_2")
}

int2bits <- function(x){
    bits <- c()
    while(x > 0){
        b <- bitwAnd(x, 1)
        bits[length(bits) + 1] <- b
        x <- bitwShiftR(x, 1)
    }
    return(bits)
}

group_hero <- function(self, l){
    UseMethod("group_hero", self)
}

group_hero.ch_2 <- function(self, group) {
    group_hero <- 0
    for (i in 1:(2**length(group) - 1)) {
        hero <- group[which(int2bits(i) == 1)]
        group_hero = group_hero + max(hero)**2 * min(hero)
    }
    return(group_hero)
}

ch_2 <- ch_2()
print(group_hero(ch_2, c(2, 1, 4)))
