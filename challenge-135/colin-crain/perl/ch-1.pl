#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       135-1-middling-thruppence.pl
#
#       Middle 3-digits
#         Submitted by: Mohammad S Anwar
#         You are given an integer.
# 
#         Write a script find out the middle 3-digits of the given integer,
#         if possible otherwise throw sensible error.
# 
#         Example 1
#             Input: $n = 1234567
#             Output: 345
#     
#         Example 2
#             Input: $n = -123
#             Output: 123
#     
#         Example 3
#             Input: $n = 1
#             Output: too short
#     
#         Example 4
#             Input: $n = 10
#             Output: even number of digits
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


## main
say middle_three( shift @ARGV ) if @ARGV;



sub middle_three ( $num ) {

    $num =~ s/^-//;
    return "input does not appear to be a number" 
        if $num =~ /\D/;

    my $len = length $num;
    return "input too short"
        if $len < 3
    return "input has an even number of digits"
        unless $len % 2
    
    while ( length $num > 3 ) {
        substr $num, -1, 1, '';
        substr $num,  0, 1, '';
    }
    
    return $num;
}



use Test::More;

is middle_three( 1234567 ), 345, 'ex-1';
is middle_three( -123    ), 123, 'ex-2';
is middle_three( 1       ), "input too short", 'ex-3';
is middle_three( 1000    ), "input has an even number of digits", 'ex-4 variant';
is middle_three( "9BAD0"    ), "input does not appear to be a number", 'alphanumeric';


done_testing();
