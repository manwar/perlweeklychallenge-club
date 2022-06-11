#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       pythagoras-was-a-meanie.pl
#
#       Pythagorean Means
#         Submitted by: Mohammad S Anwar
#         You are given a set of integers.
# 
#         Write a script to compute all three Pythagorean Means 
#             i.e Arithmetic Mean, 
#                 Geometric Mean and 
#                 Harmonic Mean 
#         of the given set of integers. 
#         Please refer to wikipedia page for more informations.
# 
#         Example 1:
#         Input: @n = (1,3,5,6,9)
#         Output: AM = 4.8, GM = 3.8, HM = 2.8
#         CORRECTION [2022-03-21 16:35] GM = 3.9 (before)
# 
#         Example 2:
#         Input: @n = (2,4,6,8,10)
#         Output: AM = 6.0, GM = 5.2, HM = 4.4
#         Example 3:
#         Input: @n = (1,2,3,4,5)
#         Output: AM = 3.0, GM = 2.6, HM = 2.2

#         Pythagorean means in the manner of Pythagoras. 
#         Which was apparently that he was mean — a real bastard.
#         I mean, that's a sort of middle-of-the-road opinion on the subject. 
#         Whatever that means.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( sum product );



sub am ( @list ) {
    return sum( @list ) / @list
}

sub gm ( @list ) {
    return product( @list ) ** (1 / @list)
}

sub hm ( @list ) {
    return @list / ( sum map { 1/$_ } @list )
}



# my @list = (1,3,5,6,9);
# 
# say sprintf "%.1f", gm( @list);
# 


use Test::More;

my @list;

@list = (1,3,5,6,9);

is ((sprintf "%.1f", am( @list)),  4.8, 'ex-1-am');
is ((sprintf "%.1f", gm( @list)),  3.8, 'ex-1-gm');
is ((sprintf "%.1f", hm( @list)),  2.8, 'ex-1-hm');


@list = (2,4,6,8,10);

is ((sprintf "%.1f", am( @list)),  '6.0', 'ex-2-am');
is ((sprintf "%.1f", gm( @list)),  5.2, 'ex-2-gm');
is ((sprintf "%.1f", hm( @list)),  4.4, 'ex-2-hm');


@list = (1,2,3,4,5);

is ((sprintf "%.1f", am( @list)),  '3.0', 'ex-3-am');
is ((sprintf "%.1f", gm( @list)),  2.6, 'ex-3-gm');
is ((sprintf "%.1f", hm( @list)),  2.2, 'ex-3-hm');

@list = (1,9);

is ((sprintf "%.1f", am( @list)),  '5.0', 'blog-am');
is ((sprintf "%.1f", gm( @list)),  3.0, 'blog-gm');
is ((sprintf "%.1f", hm( @list)),  1.8, 'blog-hm');

done_testing();
