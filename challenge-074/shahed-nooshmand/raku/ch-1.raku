(sub { .return if @_.grep(([\,] .comb).map({ .grep({ .grep($^c) == 1 })[*-1] // '#' }).join) > @_/2 for @_; -1 })(@A)
