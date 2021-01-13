([\,] .comb).map({ .grep({ .grep($^c) == 1 })[*-1] // '#' }).join
