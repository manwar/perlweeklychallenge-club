#!/usr/bin/env perl6
#
#
#       palaprime-party.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

.say for (1..1000).grep({    $_.is-prime 
                         and $_ ~~ m:ex/^ (.*) {} .? "{$0.flip}" $/});
 
