#!/usr/bin/env perl6
#
#
#       happy-happy-joy-joy.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $q = 8 ) ;


put ((1..*).grep({ happy($_) }))[0..7] ;

sub happy ($num is copy) {
    my %seen = $num, 1;
    while ( $num != 1 ) {
        $num = $num.comb.map(*²).sum and %seen{$num} ?? return 0
                                                     !! %seen{$num}++;
    }
    return 1;
}
