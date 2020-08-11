#!/usr/bin/env perl6
use v6;

sub MAIN($input-file?, :$deliminator = "\t", UInt:D :$screen-width = 80, Int :$base) {
    my $fh = $input-file ?? $input-file.IO !! $*IN;
    my @words = $fh.lines.map(*.split($deliminator));
    return unless @words.elems;  # Make sure at least one line is present

    die "All lines must have one and only one deliminator" if @words.first( { $_.elems ≠ 2 } );

    my $max-len   = @words»[0]».chars.max;              # Max label length
    my $max-value = @words»[1].max;                     # Max value
    my $min-value = @words»[1].min;                     # Min value

    if $base.defined {
        die "Base should be less or equal to minimum value" if $base > $min-value;
        $min-value = $base;
    }

    my $spread    = $max-value - $min-value;            # How far apart are max and min?
    my $max-bar   = $screen-width - $max-len - 4;       # How big the bar can be, we don't use last column
    my $unit-size = $max-bar ?? ($spread / $max-bar) !! 0;  # What a '#' represents

    for @words -> $ele {
        my $hashes = (($ele[1] - $min-value) / $unit-size).Int;
        $hashes = $max-bar if $unit-size == 0;

        say $ele[0].fmt("%-{$max-len}s") ~ " | " ~ "#" x $hashes;
    }
}

