#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# We're reading a start time, the current time, and a file name
# from STDIN, separated by white space. The file contains the
# tracks played.
#


while (<>) {
    chomp;
    my ($start_time, $current_time, $file_name) = split;
    #
    # You need a 64 bit integer for this; 32 bits of holds 
    # a five week vacation in milliseconds, but the author
    # of the puzzle lives somewhere were people take 14 week
    # holidays...
    #
    my $time_diff = ($current_time - $start_time) * 1000;

    #
    # I guess the "gradual drift of the media" must play a role
    # somehow, but I can't figure out how. Ignoring it, does 
    # gives use the right answer of the single given test case though.
    #

    open my $fh, "<", $file_name or die "open '$file_name': $!";
    my @tracks;
    my $total_time = 0;  # Total time to play the entire set of tracks;
                         # in milliseconds.
    while (<$fh>) {
        my ($play_time, $title) = split /\s*,\s*/ => $_, 2;
        push @tracks => [$play_time => $title];
        $total_time += $play_time;
    }

    #
    # We're not interested in playing full loops.
    #
    $time_diff %= $total_time;

    #
    # Find the current track playing. If $time_diff is less than the
    # play time of the track, this is the track currently playing. If
    # so, print the track name (with quotes, as given in the example --
    # although they don't belong there, as they're from the CSV encoding;
    # for that reason, we won't deescape anything else either). Otherwise
    # (track length is shorter than $time_diff), we subtrack the length
    # of the track from $time_diff, and continue checking the next track.
    #
    foreach my $track (@tracks) {
        if ($time_diff - $$track [0] < 0) {
            use integer;
            $time_diff    =  $time_diff / 1000;  # Back to seconds.
            my $hours     =  $time_diff / 3600;
            my $minutes   = ($time_diff % 3600) / 60;
            my $seconds   = ($time_diff         % 60);
            say $$track [1],
                sprintf ("%02d:%02d:%02d" => $hours, $minutes, $seconds) =~
                        s/^00://r;  # Remove leading '00:' for track
                                    # shorter than an hour.
            last;
        }
        $time_diff -= $$track [0];
    }
}
