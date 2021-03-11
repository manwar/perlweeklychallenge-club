#!/usr/bin/perl

# Challenge 103
#
# TASK #2 › What’s playing?
# Submitted by: Albert Croft
# Working from home, you decided that on occasion you wanted some background
# noise while working. You threw together a network streamer to continuously
# loop through the files and launched it in a tmux (or screen) session, giving
# it a directory tree of files to play. During the day, you connected an audio
# player to the stream, listening through the workday, closing it when done.
#
# For weeks you connect to the stream daily, slowly noticing a gradual drift of
# the media. After several weeks, you take vacation. When you return, you are
# pleasantly surprised to find the streamer still running. Before connecting,
# however, if you consider the puzzle of determining which track is playing.
#
# After looking at a few modules to read info regarding the media, a quick bit
# of coding gave you a file list. The file list is in a simple CSV format, each
# line containing two fields: the first the number of milliseconds in length,
# the latter the media’s title (this example is of several episodes available
# from the MercuryTheatre.info):
#
#     1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
#     1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
#     1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
#     1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
#     1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
#     1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
#     1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"
# For this script, you can assume to be provided the following information:
#
#     * the value of $^T ($BASETIME) of the streamer script,
#     * the value of time(), and
#     * a CSV file containing the media to play consisting of the length in
# milliseconds and an identifier for the media (title, filename, or other).
# Write a program to output which file is currently playing. For purposes of
# this script, you may assume gapless playback, and format the output as you
# see fit.
#
# Optional: Also display the current position in the media as a time-like value.
#
# Example:
#
# Input: 3 command line parameters: start time, current time, file name
#
#     # Streamer start time: Tue Nov 23 12:22:03 2020
#     1606134123
#
#     # Current time:        Mon Mar  1 09:34:36 2021
#     1614591276
#
#     # filelist.csv
#
# Output:
#
#     "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
#     00:17:33

use strict;
use warnings;
use 5.030;

@ARGV==3 or die "Usage: ch-2.pl start_secs current_secs playlist.csv\n";
my($start_secs, $current_secs, $playlist) = @ARGV;

my @playlist;
my $playlist_total_secs = 0;
open(my $fh, "<", $playlist) or die "open file $playlist: $!\n";
while (<$fh>) {
    chomp;
    my($ms, $title) = split(/,/, $_, 2);
    my $secs = int($ms/1000+0.5);
    $title =~ s/^\"(.*)\"$/$1/;
    push @playlist, [$secs, $title];
    $playlist_total_secs += $secs;
}

my $total_secs = $current_secs - $start_secs;
my $playlist_secs = $total_secs % $playlist_total_secs;

for (@playlist) {
    my($secs, $title) = @$_;
    if ($playlist_secs < $secs) {   # playing this title
        say $title;
        my $hh = int($playlist_secs/3600); $playlist_secs %= 3600;
        my $mm = int($playlist_secs/60); $playlist_secs %= 60;
        my $ss = $playlist_secs;
        say sprintf("%02d:%02d:%02d", $hh, $mm, $ss);
        last;
    }
    else {
        $playlist_secs -= $secs;
    }
}
