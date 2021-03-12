#!/usr/bin/perl -s

use v5.16;
use Mojo::CSV;
use DateTime::Format::Duration;
use Test2::V0;
use Test2::API qw(test2_add_callback_context_init);
use experimental 'signatures';

our ($tests, $examples);


run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 3;
usage: $0 [-examples] [-tests] [start now playlist]

-examples
    run the examples from the challenge
 
-tests
    run some tests

start
    starttime of streamer

now
    "current" time

playlist
    filename of playlist, must be in CSV format

call "$0 1606134123 1614591276 ch-2.csv" for the task's example.

EOS


### Input and Output

my ($start, $now, $csv) = @ARGV;
say for playing_now($start, $now, $csv);


### Implementation

# Normalizing formatter for a DateTime::Duration object.
use constant DT_D_FMT => DateTime::Format::Duration->new(
    pattern => '%r', normalize => 1);

# Find the currently running track from the playlist and the running
# time within this track given the mediaplayer start, a current time and
# a csv file containing the playlist.
sub playing_now ($start, $now, $file) {
    # Read the playlist from a CSV file or file handle.
    # Presume two fields: track duration in ms and track title.
    my $playlist = Mojo::CSV->new->slurp($file);

    # Calculate the total running time of the playlist and append the
    # individual start and end time offsets to each track along the way.
    my $total = $playlist->reduce(
        sub {
            $b->[2] = $a;           # start
            $b->[3] = $a + $b->[0]; # end
        }, 0);

    # Calculate the time from the recent playlist start till now (in
    # milliseconds).
    my $listtime = ($now - $start) * 1000 % $total;

    # Find the currently running track.
    my $current = $playlist->first(sub {$_->[3] > $listtime});

    # Return the current track's title and running time.
    ($current->[1],
        DT_D_FMT->format_duration_from_deltas(
            seconds => ($listtime - $current->[2]) / 1000));
}


### Examples and tests

sub run_tests {

    my $fh = *DATA{IO};
    my $head = tell $fh;
    test2_add_callback_context_init(sub {seek $fh, $head, 0});

    SKIP: {
        skip "examples" unless $examples;

        like [playing_now(1606134123, 1614591276, $fh)],
            [qr/Episode 1/, '00:10:24'], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        like [playing_now(1606134123, 1614590652, $fh)],
            [qr/Episode 1/, '00:00:00'], 'start of episode 1';

        like [playing_now(1606134123, 1606135832, $fh)],
            [qr/Episode 1/, '00:28:29'], 'end of episode 1';

        like [playing_now(1606134123, 1606135833, $fh)],
            [qr/Episode 2/, '00:00:00'], 'start of episode 2';

        like [playing_now(1606134123, 1606144319, $fh)],
            [qr/Episode 7/, '00:00:00'], 'start of episode 7';
	}

    done_testing;
    exit;
}

__DATA__
1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"
