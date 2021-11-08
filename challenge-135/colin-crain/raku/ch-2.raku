#!/usr/bin/env perl6
#
#
#       135-2-do-they-like-us-at-all.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use Test;

is validate_sedol( "0263494" ),     1, 'ex-0263494';
is validate_sedol( "02634940" ),    0, 'too long';
is validate_sedol( "026349" ),      0, 'too short';
is validate_sedol( "0263495" ),     0, 'wrong checksum';
is validate_sedol( "B2634Z9" ),     1, 'alpha, starts with B';







sub validate_sedol ( $code ) {

    return 0 if $code ~~ m:i/ <[AEIOU]> | \W / or $code.chars != 7;

    ## assign alphanumeric values
    my %clookup = (|('0'..'9'), |('A'..'Z')).kv.reverse;

    ## fixed SEDOL weight values 
    my @weights = 1, 3, 1, 7, 3, 9, 1;
    
    my $ws = (0..5).map({ @weights[$_] * %clookup{ $code.substr($_, 1) } })
                   .sum;

    my $cs_calculated = (10 - $ws % 10) % 10;
    my $cs_digit      = $code.substr: 6, 1;
    
    return $cs_digit == $cs_calculated 
        ?? 1
        !! 0
}




