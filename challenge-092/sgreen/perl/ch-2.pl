#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'max';

sub _new_intervals {
    my @numbers = @_;

    # The last two numbers are in the new interval
    my ( $new_start, $new_end ) = splice( @numbers, -2 );
    die "The end ($new_end) is less than the start ($new_start)\n"
      if $new_end < $new_start;

    # The rest of the numbers can be stuffed into a hash
    my %intervals        = @numbers;
    my @sorted_intervals = sort { $a <=> $b } keys %intervals;

    foreach my $start (@sorted_intervals) {
        my $end = $intervals{$start};
        die "The end ($end) is less than the start ($start)\n" if $end < $start;

        # Nothing to see here. Move on to the next interval
        next if ( $new_start > $end );

        if ( $new_start < $start ) {
            if ( $new_end < $start ) {
                # The new interval is between this interval and the
                #  previous one (if any)
                $intervals{$new_start} = $new_end;
                return \%intervals;
            }

            # The new interval intersects this one, and the start has been moved
            $intervals{$new_start} = delete $intervals{$start};
            $start = $new_start;
        }

        # Get all intervals that intersect the new interval
        my @grab = grep { $_ >= $start && $_ <= $new_end }
          sort { $a <=> $b } keys %intervals;

        # This interval ends at the greater of the new interval or the
        #  end of the last interval we used.
        $intervals{$start} = max( $new_end, $intervals{ $grab[-1] } );

        if ( scalar(@grab) > 1 ) {
            # We subsumed some other intervals, so delete them
            shift @grab;
            delete $intervals{$_} foreach @grab;
        }

        return \%intervals;
    }

    # If we got here, then the interval is beyond all intervals
    $intervals{$new_start} = $new_end;
    return \%intervals;
}

sub main {
    my @numbers = ( join( ' ', @_ ) =~ /(-?\d+)/g );

    # Sanity check
    die "You must provide me some numbers\n" unless @numbers;
    die "You must provide an even amount of numbers\n" if @numbers % 2;

    # Get an new list of intervals and display the result
    my $intervals = _new_intervals(@numbers);
    say join ', ',
      map { "($_,$$intervals{$_})" } sort { $a <=> $b } keys %$intervals;
}

main(@ARGV);
