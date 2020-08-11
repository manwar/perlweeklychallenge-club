perl6 -e 'my @a = @*ARGS[0].comb ∩ @*ARGS[1].comb; @*ARGS[1].comb.grep({$_ ∈  @a.any }).elems.say;' chancellor chocolate
