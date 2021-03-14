#!/usr/bin/env raku

use Text::CSV; # imports `csv` function

sub challenge(Int $start-time, Int $current-time, Str $file-name) returns Str {
    my @playlist          = csv(in => $file-name);
    my $playlist-length   = @playlist[*;0].sum;
    my $playlist-position = ($current-time - $start-time) * 1000 % $playlist-length;

    my ($track, $timestamp);
    for @playlist -> ($track-length, $track-name) {
        # If we are <= the playlist position, skip to the next track
        if $track-length <= $playlist-position {
            $playlist-position -= $track-length;
            next;
        }

        # We know we are in the right track now, so find how far in we are
        $track            = $track-name;
        my $total-seconds = ($playlist-position / 1000).Int;
        my $hour          = ($total-seconds / 3600).Int;
        my $minutes       = ($total-seconds % 3600 / 60).Int;
        my $seconds       = $total-seconds % 60;
        $timestamp        = sprintf('%02d:%02d:%02d', $hour, $minutes, $seconds);
        last;
    }

    "$track\n$timestamp";
}

multi sub MAIN(Int $start-time, Int $current-time, Str $file-name) {
    say challenge($start-time, $current-time, $file-name);
}

multi sub MAIN(Bool :$test) {
    use Test;

    # Write out test file.
    my @rows = (
        ('1709363', 'Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)'),
        ('1723781', 'Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)'),
        ('1723781', 'Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)'),
        ('1678356', 'Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)'),
        ('1646043', 'Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)'),
        ('1714640', 'Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)'),
        ('1714640', 'Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)')
    );
    my $test-file = 'tmp.csv';
    my $csv       = Text::CSV.new;
    my $fh        = open($test-file, :w);
    $csv.say($fh, $_) for @rows;
    $fh.close;

    my @tests = (
        (1606134123, 1614591276, $test-file, "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)\n00:10:24"),
        (1606134123, 1614592880, $test-file, "Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)\n00:08:38")
    );

    for @tests -> ($start-time, $current-time, $file-name, $expected) {
        is(challenge($start-time, $current-time, $file-name), $expected);
    }

    # Delete test file
    unlink($test-file);

    done-testing;
}
