#!/usr/bin/perl
# The Weekly Challenge 168
# Task 2 Home Prime 
# Usage: ch-2.pl [integer > 1]
use v5.24.0;
use warnings;
use Math::Prime::Util qw/is_prime next_prime/;
use Math::BigInt;

say hp($ARGV[0]) if defined($ARGV[0]) && $ARGV[0] != 1;



sub hp {
    my_hp($_[0],0);
}



sub my_hp {
    my $num = $_[0];
    my $recur_depth = $_[1];
    die "Number involved too large.\n" 
        if  
            Math::BigInt->new("18446744073709551616") # 2**64
                        ->ble( Math::BigInt->new($num) );
    

    if (is_prime($num) == 2) {
        return $num;
    }

    die "Walk so far but still cannot get result. :(\n" if $recur_depth > 20;

    my @factors = ();
    my $p = 2;
    while ($num != 1) {
        if (!($num % $p)) {
            push @factors, $p;
            $num /= $p;
        }
        else {
            $p = next_prime($p);
        }
        if ($p > sqrt $num) {
            push @factors, $num;
            last;
        }
    }
    my $nxt = join "", @factors;
    say "  $nxt";
    return my_hp($nxt, ++$recur_depth);
}

use Test::More tests => 8;
# test data from OEIS
ok hp(10) == 773;
ok hp(24) == 331_319;
ok hp(32) == 241_271;
ok hp(40) == 3314192745739;  
ok hp(44) == 22815088913;  
ok hp(45) == 3_411_949;

# bigger cases;
ok hp( 8) == 3331113965338635107;
ok hp(20) == 3318308475676071413;

# real	0m5.553s
# user	0m5.535s
# sys	0m0.016s

