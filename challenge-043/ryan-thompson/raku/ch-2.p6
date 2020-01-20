#!/usr/bin/env perl6

# ch-2.p6 - Self-descriptive numbers
#
# Ryan Thompson <rjt@cpan.org>

my @base = 0...9, 'a'...'z'; # Character set

sub MAIN( Int $base ) {
    .say for self-descriptive( $base );
}

# Return all self-descriptive numbers of a certain base
sub self-descriptive( Int $b ) {
    return @base[$b-4] ~ '21' ~ '0' x ($b-7) ~ '1000' if $b >= 7;

    ((10**($b-2) .. 10**($b-1)-1) »*» 10).grep: { is-self-descriptive($_) };
}

sub is-self-descriptive( Int $n ) {
    my @s = $n.comb;

    return False if $n.chars ≠ @s.sum; # Not a Niven number

    my %count;
    %count{ @s[$_] }++ for 0..^@s.elems;

    (0..^$n.chars).map({ (%count{$_} // 0) == @s[$_] }).all
}
