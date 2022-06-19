#!/usr/bin/perl
# The Weekly Challenge 169
# Task 1 Brilliant Numbers Version 3.0
# See https://e7-87-83.github.io/coding/challenge_169.html
#  for a simpler version, up to first 241 brilliant numbers

=pod DATA
    number of 1-digit primes =    4
    number of 2-digit primes =   21
    number of 3-digit primes =  143
    number of 4-digit primes = 1061
    number of brilliant numbers from 1-digit primes =      10
    number of brilliant numbers from 2-digit primes =     231
    number of brilliant numbers from 3-digit primes =   10296  #OEIS limit
    number of brilliant numbers from 4-digit primes =  563391
=cut

use v5.24.0;
no warnings;
use Math::Prime::Util qw/forprimes/;
use POSIX;

if (defined($ARGV[0])) {
    say bn($ARGV[0]);
}
else {
    say bn(20);
}



sub bn {
    my $req = $_[0];
    my $show_all_values = $req <= 50; 
    # show all values if the required number is small

    my %prime = (1 => [2, 3, 5, 7],
                 2 => [11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 
                       47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97],
                 3 => [],
                 4 => [],
                );

    my $digit_len;

    given ($req) {
        $digit_len = 1 when $_ <= 10;
        $digit_len = 2 when $_ > 10 && $_ <= 241;
        $digit_len = 3 when $_ > 241 && $_ <= 10537;
        $digit_len = 4 when $_ > 10537 && $_ <= 573928;
        die "You're asking too many!\n" when $_ > 573928;
    }

    eval { forprimes {push $prime{3}->@*, $_}  100, 999; } if $digit_len >= 3; 
    eval { forprimes {push $prime{4}->@*, $_} 1000,9999; } if $digit_len >= 4;

    my $ind = $req;
    $ind = $req-10 if $digit_len == 2;
    $ind = $req-241 if $digit_len == 3;
    $ind = $req-10537 if $digit_len == 4;
    my $c = 3;
    $c = ceil( ( sqrt(8*$ind+1) - 1 ) / 2 ) - 1;

    my @temp;

    for my $i (0..$c) {
        for my $j ($i..scalar $prime{$digit_len}->@* - 1) {
            my $product = $prime{$digit_len}[$i]*$prime{$digit_len}[$j];
            push @temp, $product;
        }
    }
    @temp = sort {$a<=>$b} @temp;
    if ($show_all_values) {
        my @brilliant = (-1, 4, 6, 9, 10, 14, 15, 21, 25, 35, 49);
        push @brilliant, @temp;
        say join "\n", @brilliant[1..$req];
        return;
    }
    return $temp[$ind-1];
}



use Test::More tests=> 13;
ok bn(60) == 841;
ok bn(80) == 1079;
ok bn(100) == 1369;
ok bn(120) == 1763;
ok bn(140) == 2231;
ok bn(160) == 2809;
ok bn(241) == 9409;
ok bn(5000) == 197503;
ok bn(10000) == 696191;
ok bn(10416) == 851927;
ok bn(10537) == 994009;
ok bn(10538) == 1009*1009;
ok bn(573928) == 9973*9973;

# ref: OEIS:A078972

