#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       do-they-like-us-at-all.pl
#
#       Validate SEDOL
#         Submitted by: Mohammad S Anwar
#         You are given 7-characters alphanumeric SEDOL.
# 
#         Write a script to validate the given SEDOL. 
#         Print 1 if it is a valid SEDOL otherwise 0.
# 
#         For more information about SEDOL, please checkout the wikipedia page.
# 
#         Example 1
#             Input: $SEDOL = '2936921'
#             Output: 1
#             
#         Example 2
#             Input: $SEDOL = '1234567'
#             Output: 0
# 
#         Example 3
#             Input: $SEDOL = 'B0YBKL9'
#             Output: 1
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
say validate_sedol( shift @ARGV ) if @ARGV;



sub validate_sedol ( $candidate ) {

    return 0 if $candidate =~ m/ [AEIOU] | \W /ix or length $candidate != 7 ;

    ## assign alphanumeric values
    my $val = -1;
    my %clookup = map { $_ => ++$val } (0..9, 'A'..'Z');

    ## fixed SEDOL weight values 
    my $ws = 0;
    my @weights = (1, 3, 1, 7, 3, 9, 1);

    $ws += $weights[$_] * $clookup{ substr $candidate, $_, 1 } for (0..5);

    my $cs_calculated = ( 10 - $ws % 10) % 10;
    my $cs_digit      = substr $candidate, 6, 1;

    return $cs_digit == $cs_calculated 
        ? 1 
        : 0 ;
}







use Test::More;

is validate_sedol( "0263494" ),     1, 'ex-0263494';
is validate_sedol( "02634940" ),    0, 'too long';
is validate_sedol( "026349" ),      0, 'too short';
is validate_sedol( "0263495" ),     0, 'wrong checksum';
is validate_sedol( "B2634Z9" ),     1, 'alpha, starts with B';

done_testing();


