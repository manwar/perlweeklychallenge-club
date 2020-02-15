#!/usr/bin/env perl6

# ch-2.p6 - Doors that are square
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Int $doors = 500 ) {

    # Justification: http://www.ry.ca/2020/02/500-doors/
    say (1..$doors.sqrt.Int) »**» 2;


    # That's fine, I can do it the hard way:
    my %doors;
    for 1..$doors -> $m {
        %doors{$m*$_} ^^= 1 for 1..$doors/$m;
    }

    say %doors.grep({ .value })».key».Int.sort;

}
