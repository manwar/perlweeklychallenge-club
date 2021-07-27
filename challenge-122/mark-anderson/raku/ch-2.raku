#!/usr/bin/env raku

unit sub MAIN(UInt $S);

.say for b-ball-points($S);

multi b-ball-points($S where * == 1) { (1,), }
multi b-ball-points($S where * == 2) { (1, 1), (2,) }
multi b-ball-points($S where * == 3) { (1, 1, 1), (1, 2), (2, 1), (3,) } 
    
multi b-ball-points($S) 
{
    (1..2**($S-1)-1)
    .map({ (.fmt('%0' ~ $S ~ 'b') ~~ m:g/ (.) [$0+]? /).map({ .chars }) })
    .grep({ .cache.all < 4 })
}
