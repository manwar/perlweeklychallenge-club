#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       multi-list.pl
#
#
#       Multiplication Table
#         Submitted by: Mohammad S Anwar
#         You are given 3 positive integers, $i, $j and $k.
# 
#         Write a script to print the $kth element in the sorted
#         multiplication table of $i and $j.
# 
#         Example 1
#             Input: $i = 2; $j = 3; $k = 4
#             Output: 3
# 
#         Since the multiplication of 2 x 3 is as below:
# 
#             1 2 3
#             2 4 6
# 
#         The sorted multiplication table:
# 
#             1 2 2 3 4 6
# 
#         Now the 4th element in the table is "3".
# 
#         Example 2
#             Input: $i = 3; $j = 3; $k = 6
#             Output: 4
# 
#         Since the multiplication of 3 x 3 is as below:
# 
#             1 2 3
#             2 4 6
#             3 6 9
# 
#         The sorted multiplication table:
# 
#             1 2 2 3 3 4 6 6 9
# 
#         Now the 6th element in the table is "4".
# 
# 
#       method:
#         
#         What an interesting puzzle. 
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




## sample data
my $m = 3;
my $n = 3;
my $target_index = 6;

say nth_multi( $m, $n, $target_index );

my %mult;

sub nth_multi ( $m, $n, $idx ) {
    for my $i ( 1..$m ) {
        $mult{$_}++ for map { $i * $_ } ( 1..$n );
    }

    my ($count, $out);
    for ( sort {$a<=>$b} keys %mult ) {
        $count += $mult{ $_ };
        $out = $_;
        return $_ if $count >= $idx;
    }

    return $out;
}

