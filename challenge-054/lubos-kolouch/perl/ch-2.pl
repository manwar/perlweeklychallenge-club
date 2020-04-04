#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my %length_cache;

sub get_next_sequence {
    my $seq_pos = shift;

    return 0 if $seq_pos == 1;
    return 3 * $seq_pos + 1 if $seq_pos % 2 == 1;
    return int( $seq_pos / 2 );
}

sub single_sequence {
    my $seq_pos = shift;

    # For the first task, it is easier to separate to own function

    my @seq;
    while ( $seq_pos > 1 ) {
        push @seq, $seq_pos;
        $seq_pos = get_next_sequence($seq_pos);
    }
    push @seq, 1;
    return \@seq;
}

sub get_sequence_length {
    my $seq_pos = shift;

    if ($seq_pos == 1) {
        $length_cache{1} = 1;
        return 1;
    }

    my $seq_length;

    my $cur_pos = $seq_pos;

    while ( $cur_pos >= 1 ) {

        if ( $length_cache{$cur_pos} ) {

            # If we have already the length cached, return it
            $seq_length += $length_cache{$cur_pos};
            last;
        }

        # otherwise increse the length and move to next step
        $seq_length++;
        $cur_pos = get_next_sequence($cur_pos);
    }
    $length_cache{$seq_pos} = $seq_length;

    return $seq_length;
}

my $result = single_sequence(23);
warn Dumper \$result;

for (1..1_000_000) {
    get_sequence_length($_);
}

my $count;
foreach my $name (sort { $length_cache{$b} <=> $length_cache{$a} } keys %length_cache) {
    printf "%-8s %s\n", $name, $length_cache{$name};
    $count++;
    last if $count == 20;
}

# --- TESTS ---

use Test::More;

$result = single_sequence(23);
is(@$result,16);
done_testing();
