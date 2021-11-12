#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       lychrel.pl
#
#       137-2 Lychrel Number
#         Submitted by: Mohammad S Anwar
#         You are given a number, 10 <= $n <= 1000.
# 
#         Write a script to find out if the given number is Lychrel number.
#         To keep the task simple, we impose the following rules:
# 
#         a. Stop if the number of iterations reached 500.
#         b. Stop if you end up with number >= 10_000_000.
#         According to wikipedia:
# 
#         A Lychrel number is a natural number that cannot form a
#         palindrome through the iterative process of repeatedly reversing
#         its digits and adding the resulting numbers.
# 
#         Example 1
# 
#             Input: $n = 56
#             Output: 0
#     
#             After 1 iteration, we found palindrome number.
#             56 + 65 = 121
# 
#         Example 2
# 
#             Input: $n = 57
#             Output: 0
#     
#             After 2 iterations, we found palindrome number.
#              57 +  75 = 132
#             132 + 231 = 363
# 
#         Example 3
# 
#             Input: $n = 59
#             Output: 0
#     
#             After 3 iterations, we found palindrome number.
#              59 +  95 =  154
#             154 + 451 =  605
#             605 + 506 = 1111
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use integer;


for my $num ( 10..1000 ) {
    say "input:  $num";
    my @ret = lychrel( $num );
    say "output: ", $ret[0];
    ref($ret[1]) eq 'ARRAY' 
        ?  do {say "steps: (", scalar $ret[1]->@*, ")"; say "\t $_" for $ret[1]->@*} 
        :  say $ret[1]; 
    say '';
}

sub lychrel ( $num ) {
    my @chain = ($num);
    return (0, @chain) if $num == reverse $num;
    for (1..500) {
        my $revsum = $num + reverse $num;
        push @chain, $revsum;
        return (0, \@chain) if $revsum == reverse $revsum;
        $num = $revsum;
        return (1, "number too large: $num") if $num > 10_000_000;
    }
    say (1, "too many iterations, more than 500");
}

