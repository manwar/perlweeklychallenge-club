#!/usr/bin/env raku

use experimental :cached;

#`{ This looks very elegant but unfortunately, cached is broken with multiple dispatch and therefore the calls grow exponentially
multi max-sum(($x1, $x2, *@tl)) { max(max-sum(($x2, |@tl)), $x1 + max-sum(@tl)) }
multi max-sum(($x,)) {$x}
multi max-sum(() --> 0) {}
}

sub max-sum(@list) is cached {
  given @list {
    when 0 { 0 }
    when 1 { @list.first }
    default { max max-sum(@list.skip), @list.first + max-sum(@list.skip: 2) } 
  }
}

say max-sum((1,3,2,4,4,1,9,1)); #16
say max-sum((2, 4, 5)); #7
say max-sum((4, 2, 3, 6, 5, 3)); #13
