#!/usr/bin/env perl6

say &most-frequent-even((1,1,2,6,2)); #2
say &most-frequent-even((1,3,5,7)); #-1
say &most-frequent-even((6,4,4,6,1)); #4;


sub most-frequent-even (@list) {
    (my @evens = @list.grep(* %% 2)) || (return -1);
  
    my $max-freq = @evens.Bag.values.max;
    
    @evens.Bag.pairs.grep({$_.value == $max-freq}).map({$_.key}).min;  
}
