#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
# 
#       professional_esthetics.pl
# 
#       Esthetic Number
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer, $n.
# 
#         Write a script to find out if the given number is Esthetic
#         Number.
# 
# 
#         An esthetic number is a positive integer where every adjacent
#         digit differs from its neighbour by 1.
# 
# 
#         For example,
# 
#         5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
#         120 is not an esthetic numner as |1 - 2| != |2 - 0| != 1
# 
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



sub is_esthetic ($num) {
    for (0..length($num)-2) {
        abs(substr($num,$_,1)-substr($num,$_+1,1)) == 1 or return 0 ;
    }
    return 1;
}



use Test::More;

is is_esthetic(5456)            ,1, 'ex-1';
is is_esthetic(120)             ,0, 'ex-2';
is is_esthetic(123434345678)    ,1, 'fancy';
is is_esthetic(54)              ,1, 'short';
is is_esthetic(5)               ,1, 'very short';
is is_esthetic(555)             ,0, 'plain';

done_testing();
