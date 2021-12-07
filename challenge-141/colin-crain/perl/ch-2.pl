#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       i-lk-u.pl
#
#       Like Numbers
#         Submitted by: Mohammad S Anwar
#         You are given positive integers, $m and $n.
# 
#         Write a script to find total count of integers created using the
#         digits of $m which is also divisible by $n.
# 
#         Repeating of digits are not allowed. Order/Sequence of digits
#         can’t be altered. You are only allowed to use (n-1) digits at the
#         most. For example, 432 is not acceptable integer created using
#         the digits of 1234. Also for 1234, you can only have integers
#         having no more than three digits.
# 
#         Example 1:
# 
#             Input: $m = 1234, $n = 2
#             Output: 9
#     
#             Possible integers created using the digits of 1234 are:
#                 1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.
#     
#             There are 9 integers divisible by 2 such as:
#                 2, 4, 12, 14, 24, 34, 124, 134 and 234.
# 
#         Example 2:
# 
#             Input: $m = 768, $n = 4
#             Output: 3
#     
#             Possible integers created using the digits of 768 are:
#                 7, 6, 8, 76, 78 and 68.
#     
#             There are 3 integers divisible by 4 such as:
#                 8, 76 and 68.
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $m = shift @ARGV // 76876522;
my $n = shift @ARGV // 143;

say "input  number m : ", $m;
say "input divisor n : ", $n;
say "integers found  : ", join ', ', get_divs( $n, get_ints( $m ));

sub get_ints( $num ) {
    my $len  = length($num);
    my @bins = map { sprintf "%0${len}b", $_ } (1 .. 2**$len - 1);
    my @out;
    
    for my $b ( @bins ) {
        my $combi;
        for my $idx (0..$len-1) {
            $combi .= (substr $b, $idx, 1)
                          ? substr $num, $idx, 1
                          : ''
        }
        push @out, $combi unless $combi == $num;
    }
    
    return sort {$a<=>$b} @out;
}


sub get_divs ( $div, @nums ) {
    return grep { not $_ % $div } @nums;

}



