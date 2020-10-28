#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use List::Util qw(sum uniq);

sub main {
    my @numbers = @_;
    my $items   = scalar(@numbers);

    # Sanity check
    die "You must specify at least one value" unless scalar(@numbers);
    foreach my $n (@numbers) {
        die "The value '$n' is not a positive number\n"
          unless $n =~ /^[1-9][0-9]*$/;
    }

    # Set up some variables. We start with the minimum sum being one
    #  more than the sum of the numbers.
    my $minimum_sum   = sum(@numbers) + 1;
    my $minimum_flips = 0;
    my @results       = ();

    # We use a binary counter representing the binary values for each
    #  number. If true, we will flip the value.
    foreach my $x ( 0 .. 2**$items - 2 ) {
        my @combination =
          map { $x & 2**$_ ? -$numbers[$_] : $numbers[$_] } 0 .. $#numbers;
        my $flips = scalar( grep { $_ < 0 } @combination );
        my $sum   = sum(@combination);
        next if $sum < 0;

        if ( $sum < $minimum_sum
            || ( $sum == $minimum_sum && $flips < $minimum_flips ) )
        {
            # We have a new leading combination
            $minimum_sum   = $sum;
            $minimum_flips = $flips;
            @results       = ( join ' ', sort { $a <=> $b } @combination );
        }
        elsif ( $sum == $minimum_sum && $flips == $minimum_flips ) {
            push @results, join ' ', sort { $a <=> $b } @combination;
        }
    }

    say "RESULT IS: $minimum_flips (", join( ', ', uniq(@results) ), ')';
}

main(@ARGV);
