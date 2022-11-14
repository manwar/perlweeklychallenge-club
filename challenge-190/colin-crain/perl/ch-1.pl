#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       capital-idea.pl
#
#         Capital Detection
#         Submitted by: Mohammad S Anwar
#         You are given a string with alphabetic characters only: 
#           A..Z and a..z.
# 
#         Write a script to find out if the usage of Capital is appropriate
#         if it satisfies at least one of the following rules:
# 
#             1) Only first letter is capital and all others are small.
#             2) Every letter is small.
#             3) Every letter is capital.
# 
#         Example 1
#             Input: $s = 'Perl'
#             Output: 1
# 
#         Example 2
#             Input: $s = 'TPF'
#             Output: 1
# 
#         Example 3
#             Input: $s = 'PyThon'
#             Output: 0
# 
#         Example 4
#             Input: $s = 'raku'
#             Output: 1
# 
# 
#         method;
#             the rules, streamlined:
#                 - if first letter is capital:
#                     - all others must be
#                     - or no others must be
#                 - else (first letter is not capital and) 
#                       no other is capital
#                 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub valdate_capitalization ( $str ) {
    $str =~ /^[A-Z]([A-Z]*$|[a-z]*$)|^[a-z]+$/ 
        ? 1
        : 0 ;
}


use Test::More;

is valdate_capitalization( 'Perl' ),      1, 'ex-1';
is valdate_capitalization( 'TPF' ),       1, 'ex-2';
is valdate_capitalization( 'PyTHon' ),    0, 'ex-3';
is valdate_capitalization( 'raku' ),      1, 'ex-4';

done_testing();
