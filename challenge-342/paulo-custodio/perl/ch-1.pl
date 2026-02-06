#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";

say balance($ARGV[0]);

sub balance {
    my ($str) = @_;

    # Separate and sort characters for lexicographical order
    my @letters = sort grep { /[a-z]/ } split //, $str;
    my @digits  = sort grep { /[0-9]/ } split //, $str;

    my $l_count = scalar @letters;
    my $d_count = scalar @digits;

    # Check if a balanced arrangement is impossible
    return "" if abs($l_count - $d_count) > 1;

    # Determine the starting pool
    # If counts are unequal, the larger group MUST start.
    # If counts are equal, both can start; pick the smaller character.
    my $next_pool;
    if ($l_count > $d_count) {
        $next_pool = \@letters;
    }
    elsif ($d_count > $l_count) {
        $next_pool = \@digits;
    }
    else {
        # Counts are equal: pick the smaller of the two first available chars
        $next_pool = ($letters[0] le $digits[0]) ? \@letters : \@digits;
    }

    my $out = "";
    my @pools = ($next_pool == \@letters) ? (\@letters, \@digits) : (\@digits, \@letters);

    # Alternatingly build the string
    while (@{$pools[0]} || @{$pools[1]}) {
        return "" if !@{$pools[0]}; # Safety check
        $out .= shift @{$pools[0]};
        @pools = reverse @pools;    # Swap pools for the next character
    }

    return $out;
}
