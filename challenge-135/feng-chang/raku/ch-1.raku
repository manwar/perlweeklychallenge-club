#!/bin/env raku

=begin usage

 ./ch-1.raku -- -1234

=end   usage

sub MAIN(Int:D $N) {
    given abs($N) {
        when $_.chars %% 2 { put 'even number of digits'; exit    }
        when $_.chars  < 3 { put 'too short';             exit    }
        default            { put $_.substr($_.chars div 2 - 1, 3) }
    }
}
