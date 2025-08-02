#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 294 Task 1: Consecutive Sequence
#
#       Perl solution by Matthias Muth.
#

use v5.40;
use experimental 'class';

use Verbose;
# $verbose = 1;

use List::Util qw( uniq );

sub consecutive_sequence_using_hash( @ints ) {
    my $max_streak_length = -1;
    my %streaks;
    for my $n ( uniq @ints ) {
        vsay "processing $n";

        # Create a new streak from this number,
        # possibly merged with any existing adjacent streaks
        # to the left or to the right.
        my ( $left, $right ) =
            ( $streaks{ $n - 1 }, $streaks{ $n + 1 } );
        vsay "  merge with ", map " " . pp( $_ ), $left, $right
            if $left || $right;
        my ( $from, $to ) = (
            $left ? $left->{FROM} : $n,
            $right ? $right->{TO} : $n,
        );
        my $streak = { FROM => $from, TO => $to };

        # Update the lookup entries:
        # Remove any entries that are *inside* the merged streak,
        # and add or update entries at the streak borders.
        delete $streaks{ $left->{TO} }
            if $left;
        delete $streaks{ $right->{FROM} }
            if $right;
        $streaks{$from} = $streaks{$to} = $streak;
        vsay "  ", pp( $streak );
        vsay "  ", pp( \%streaks );

        # Update the maximum length if this is a streak
        # (not just a single number).
        $max_streak_length = $to - $from + 1
            if $to > $from && $to - $from + 1 > $max_streak_length;
    }
    return $max_streak_length;
}

#
#   consecutive_sequence using a Streak class
#
class Streak {
    use Verbose;
    use List::Util qw( min max );

    field $start :param :reader;
    field $end   :param :reader;

    method merge( $other ) {
        vprint "  merging $self and $_";
        ( $start, $end ) = (
            min( $start, $other->start ),
            max( $end,   $other->end   ),
        );
        vsay " to $self";
        return $self;
    }

    method as_string( @args ) { return __CLASS__ . "($start..$end)" }
    use overload '""' => \&as_string;
}

use List::Util qw( uniq );

sub consecutive_sequence_using_class( @ints ) {
    my $max_streak_length = -1;
    my %streaks;
    for my $n ( uniq @ints ) {
        vsay "processing $n";

        # Create a new streak just from this number,
        # and maintain the lookups.
        my $streak = Streak->new( start => $n, end => $n );
        $streaks{$n} = $streak;
        vsay " streak $streak";

        # Try to merge with any existing adjacent streaks
        # to the left or to the right.

        for ( $streaks{ $n - 1 }, $streaks{ $n + 1 } ) {
            next unless $_;

            $streak->merge( $_ );

            # Update the lookup entries:
            # Remove both entries of the streak we merged,
            # then add entries for the new one at the streak borders.
            delete $streaks{$_->end};
            delete $streaks{$_->start};
            $streaks{ $streak->start } =
                $streaks{ $streak->end } = $streak;

            # Update the maximum length.
            $max_streak_length = $streak->end - $streak->start + 1
                if $streak->end - $streak->start + 1 > $max_streak_length;
        }
    }
    return $max_streak_length;
}

#
#   consecutive_sequence
#   using a 'SimpleStreak' class for the streak data,
#   and a 'Streaks' class that maintains the streak lookups.
#
class SimpleStreak {
    field $start :param :reader;
    field $end   :param :reader;

    method as_string( @args ) { return __CLASS__ . "($start..$end)" }
    use overload '""' => \&as_string;
}

class Streaks {
    field %streaks :reader;
    field $max_streak_length :reader = -1;

    method add_element( $n ) {
        # Create a new streak merging this element with any existing neighbors.
        my ( $left, $right ) =
            ( $streaks{ $n - 1 }, $streaks{ $n + 1 } );
        my $streak = SimpleStreak->new(
            start => $left  ? $left->start : $n,
            end   => $right ? $right->end  : $n,
        );

        # Update the lookup entries:
        # Remove any entries that are *inside* the merged streak,
        # and add or update entries at the streak borders.
        delete $streaks{$left->end}
            if $left;
        delete $streaks{$right->start}
            if $right;
        $streaks{$streak->start} = $streaks{$streak->end} = $streak;

        # Update the maximum length if this is a real streak
        # (not just a single number).
        my $length = $streak->end - $streak->start + 1;
        $max_streak_length = $length
            if $length > 1 && $length > $max_streak_length;

        return $self;
    }

    method as_string( @args ) {
        return join "",
            __CLASS__, "(\n",
            ( map "        $_ => $streaks{$_}\n",
                sort { $a <=> $b } keys %streaks ),
            ")";
    }
    use overload '""' => \&as_string;
}

use List::Util qw( uniq );

sub consecutive_sequence_using_classes( @ints ) {
    my $streaks = Streaks->new;
    $streaks->add_element( $_ )
        for uniq @ints;
    return $streaks->max_streak_length;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

my $sub_name = "consecutive_sequence";
my @tests = (
    [ 'Example 1:', [ 10, 4, 20, 1, 3, 2 ], 4 ],
    [ 'Example 2:', [ 0, 6, 1, 8, 5, 2, 4, 3, 0, 7 ], 9 ],
    [ 'Example 3:', [ 10, 30, 20 ], -1 ],
);

sub run_test( $sub, $descr, $input, $output ) {
    if ( ! ref $output && $output =~ /^(?:(true)|false)$/i ) {
        my $expected_true = $1;
        $descr .=
            " $sub( " . join( ", ", map pp( $_ ), $input->@* ) . " )"
            . " is $output"
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
        $expected_true
        ? ok $sub->( $input ), $descr
        : ok ! $sub->( $input ), $descr;
    }
    else {
        $descr .= " " . pp( $input ) . " => $output"
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
        my @input = ref $input ? $input->@* : ( $input );
        is $sub->( @input ), $output, $descr;
    }
}

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    run_test( $sub, $_->@* )
        for @tests;
}

done_testing;