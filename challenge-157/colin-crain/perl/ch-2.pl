#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       waxing-numeric.pl
#
#       Brazilian Number
#         Submitted by: Mohammad S Anwar
#         You are given a number $n > 3.
# 
#         Write a script to find out if the given number is a Brazilian
#         Number.
# 
#         A positive integer number N has at least one natural number B
#         where 1 < B < N-1 where the representation of N in base B has
#         same digits.
# 
# 
#         Example 1:
#             Input: $n = 7
#             Output: 1
#     
#             Since 7 in base 2 is 111.
# 
#         Example 2:
#             Input: $n = 6
#             Output: 0
#     
#             Since 6 in base 2 is 110,
#                   6 in base 3 is 20 and
#                   6 in base 4 is 12.
# 
#         Example 3:
#             Input: $n = 8
#             Output: 1
#     
#             Since 8 in base 3 is 22.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use constant { ANALYSE => 0 };
use constant { COUNT   => 2000 };


if (ANALYSE) {
    analyse( COUNT );
}
else {
    my $input = shift @ARGV // 1993;
    say "input:  $input";
    say "output: ", brazilian( $input ) ? 1 : 0;
    
    say digit_test_36( 100, 99);
}


## ## ## the task 

sub brazilian ( $num ) {
## up/down check if number is a Brazilian number
    for ( 2..$num-2 ) {
        return $_ if digit_test( $num, $_ );
    }
    return 0;
}

sub digit_test ( $num, $base ) {
## up/down check for all digits are the same in a given base 
## converts from base-10 to any given base
## does not internally store converted number other than 
## single digit as base-10 sequence index: conditional 
## 1 short-circuits returning 0 if non-repeated digit found, 
## otherwise returns 1
    my $rem; 
    my $digit;
    while ( $num > 0  ) {
        ($num, $rem) = (int( $num/$base ), $num % $base);   
        $digit //= $rem;
        return 0 if $digit != $rem;
    }
    return 1;
}

## ## ## /task


## analysis section
sub analyse ( $count ) {

    my $match;
    my @coef;
    for (2..$count) {
        my $b = brazilian( $_ );
        next if $b == 0;
         push @coef, $b;
   
        my @pdiv = nd_brute( $_ );
    
        for my $div ( 2..42 ) {
            next unless $b == $_/$div - 1;
            $match = "match 1/${div}-1";
            last;
        }
    
        $match ||= (sprintf "\t%.2f     ", $_/$b);
        say sprintf "%3d    %-3d     %-20s %s", $_, $b, $match, "@pdiv";
        $match = undef;
    }

    my @a = grep { brazilian($_) } (2..200);
    say "@a";
    say "@coef";
    
    sub nd_brute ( $num, @div ) {
        $num % $_ or push @div, $_ for 2..$num/2 ;    
        return @div;
    }
}    
## /analysis

