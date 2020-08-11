#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;


use Math::BigRat;

sub main() {
    die "Usage: $0 <digits>" if @ARGV > 1;
    my $digits = ( shift @ARGV ) // 10;
    die "Usage: $0 <digits>" if $digits !~ m/^[0-9]+$/ms;

    return unless $digits;
    if ( $digits == 1 ) {
        say "2";
        return;
    }

    my $e       = Math::BigRat->new(2);
    my $current = Math::BigRat->new(1);
    my $denom   = Math::BigRat->new(1);

    my $chkdigits = $digits;

    do {
        $current++;
        $denom *= $current;

        $e += Math::BigRat->new("1/$denom");
        if (length($denom) >= $chkdigits + 3) {  # 2 should be enough, but we'll be safe
            my $digit = ((int $e * (Math::BigRat->new(10)**$chkdigits)) % 10);
            if ($digit =~ m/[49]$/) {
                $chkdigits++;
            }
        }
    } while ( length($denom) < $chkdigits + 3 );

    say $e->as_float($digits);
    return;
}

main();
