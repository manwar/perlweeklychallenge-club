#!/usr/bin/env perl6
use v6;

sub MAIN(UInt:D $num) {
    # Yes, quotes in interpolation in quotes works in Perl6!
    say "$num = {prime-factors($num).sort.join(" × ")}";
}

# Perl 6 makes beautiful recursion.  :)

multi sub prime-factors(0)                            { return @(0) }
multi sub prime-factors(1)                            { return @(1) }
multi sub prime-factors(UInt:D() $i where *.is-prime) { return @($i) }
multi sub prime-factors(UInt:D() $i) {
    return @($i) if $i.is-prime;

    my $sqrt = sqrt($i).Int;
    my $first = (2..$sqrt).first( $i %% * );

    my @others = prime-factors($i / $first);
    @others.push($first);

    return @others;
}

