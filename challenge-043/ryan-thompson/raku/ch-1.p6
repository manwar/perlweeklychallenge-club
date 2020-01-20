#!/usr/bin/env perl6

# ch-1.p6 - Olympic Rings
#
# Ryan Thompson <rjt@cpan.org>

# Givens, and numbers available for use
my %given = :r(9), :g(5), :y(7), :b(8);
my $avail = set (1..4, 6);
my @order = <rg gk k ky yb>; # Left-to-right unsolved

solve().say;

# Backtracking solver
sub solve( Hash $sol = { } ) {
    given check-sol( $sol ) {
         return $sol when 'solved';
         return      when 'impossible';
    }

    # List of numbers still available
    my $rem = $avail ∖ $sol.values;

    my $spot = @order.first({ !$sol{$_} });
    for $rem.keys.sort -> $num {
        return $_ if .defined given solve($sol.clone.append($spot, $num));
    }

}

# Check solution
sub check-sol( %sol ) {
    my @rings = <r+rg rg+g+gk gk+k+ky ky+y+yb yb+b>;
    my @sums = @rings.map({
        .split('+').map({ %sol{$_} || %given{$_} || -∞ }).sum;
    });

    return 'solved'     if @sums.all == 11;
    return 'impossible' if @sums.grep({ $_ ≠ 11 and $_ > 0 });
    return 'possible';
}

