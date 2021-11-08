#!/usr/bin/env perl6
#
#
#       137-1-long-cat-years.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my @out = gather {
    for 1900..2100 {
        my $d = Date.new( $_, 12, 28 );
        take $d.year if $d.week-number == 53;
    }
}

.join(', ')
.say        
    for @out.rotor(5, :partial);
