use strict;
use warnings;
##
# Write a script to generate first 5 Pandigital Numbers in base 10.
##
use boolean;

sub first_n_pandigitals {
    my ($n)         = @_;
    my $found       = false;
    my $pandigitals = [];
    my $x           = 1_000_000_000;
    do {
        my $test = $x;
        push @{$pandigitals}, $x
          if ( $test =~ tr/0//d ) > 0
          && ( $test =~ tr/1//d ) > 0
          && ( $test =~ tr/2//d ) > 0
          && ( $test =~ tr/3//d ) > 0
          && ( $test =~ tr/4//d ) > 0
          && ( $test =~ tr/5//d ) > 0
          && ( $test =~ tr/6//d ) > 0
          && ( $test =~ tr/7//d ) > 0
          && ( $test =~ tr/8//d ) > 0
          && ( $test =~ tr/9//d ) > 0;
        $found = ( @{$pandigitals} == $n );
        $x++;
    } while ( !$found );
    return $pandigitals;
}

sub first_5_pandigitals {
    return first_n_pandigitals(5);
}
MAIN: {
    my $pandigitals = first_5_pandigitals;
    for my $x ( @{$pandigitals} ) {
        print "$x\n";
    }
}
