#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challeng 103, Task #2, What's playing?
#
# Working from home, you decided that on occasion you wanted some background
# noise while working. You threw together a network streamer to continuously
# loop through the files and launched it in a tmux (or screen) session, giving
# it a directory tree of files to play. During the day, you connected an audio
# player to the stream, listening through the workday, closing it when done.
#
# For weeks you connect to the stream daily, slowly noticing a gradual drift
# of the media. After several weeks, you take vacation. When you return, you
# are pleasantly surprised to find the streamer still running. Before
# connecting, however, if you consider the puzzle of determining which track
# is playing.
#
# After looking at a few modules to read info regarding the media, a quick bit
# of coding gave you a file list. The file list is in a simple CSV format,
# each line containing two fields: the first the number of milliseconds in
# length, the latter the media’s title
#
# For this script, you can assume to be provided the following information:
#    * the value of $^T ($BASETIME) of the streamer script,
#    * the value of time(), and
#    * a CSV file containing the media to play consisting of the length in
#      milliseconds and an identifier for the media (title, filename, or other).
#
# Write a program to output which file is currently playing. For purposes of
# this script, you may assume gapless playback, and format the output as you
# see fit.
# Optional: Also display the current position in the media as a time-like value.
#
# Example: Input starttime   currenttime  filelist.csv
#                1606134123  1614591276   episode.csv
# Output:
# "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
# 00:10:24
# 
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/signatures/;
no warnings qw/experimental::signatures/;

use Getopt::Long;
my $verbose = 0;
my $doTest = 0;

use FindBin qw($Bin);
use lib "$FindBin::Bin";
use lib "$FindBin::Bin/lib";

# Using this as an excuse to use Moo
use PlayList;

GetOptions("test" => \$doTest, "verbose" => \$verbose);

exit(!runTest()) if $doTest;

sub Usage() { "Usage: $0 startTS endTS file.csv" }

my $startTS = shift;
my $endTS   = shift;
my $file    = shift;
die Usage() unless defined $startTS && defined $endTS && defined $file;
die Usage(), " start > end" if $startTS > $endTS;

my $playList = PlayList->new( fileName  => $file );
use Data::Dumper;
# say Dumper($playList);

# Because the time is in seconds and track time is in millisconds, there's
# a possibility that we could switch tracks in that second.  Specifications
# are ambiguous, so do the simplest that works -- use the start of the second.
my $playTime = ($endTS - $startTS) * 1000; # In milliseconds

my ($track, $timeIntoTrack, $timeIntoCycle) = $playList->playingAt($playTime);
# time is in millisconds

# Turn a time in milliseconds into format "HH:MM:SS", dropping fractional seconds.
sub posFormat($pos)
{
    use integer;
    my ($hours, $minutes, $seconds) = (0, 0, 0);
    $pos /= 1000; # Now in seconds
    $hours = $pos / 3600;
    $pos %= 3600;
    $minutes = $pos / 60;
    $seconds = $pos % 60;

    return sprintf("%02d:%02d:%02d", $hours, $minutes, $seconds);
}

say $track;
say posFormat($timeIntoTrack), " in episode";
say posFormat($timeIntoCycle), " in cycle of ", posFormat($playList->length);

sub runTest()
{
    use Test::More;

    my $pl = PlayList->new(fileName => "episode.csv");
    is( $pl->length(), 11910604, "Total length");

    my ($track, $songTime, $cycleTime) = $pl->playingAt(0);
    is( $track, "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)", , "track at 0 ms");
    is( posFormat($songTime), "00:00:00", "Time at 0 ms");
    is( posFormat($cycleTime), "00:00:00", "Cycle at 0 ms");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1);
    is( $track, "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)", , "track at 1 ms");
    is( posFormat($songTime), "00:00:00", "Time at 1 ms");
    is( posFormat($cycleTime), "00:00:00", "Cycle at 1 ms");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1000);
    is( $track, "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)", , "track at 1 sec");
    is( posFormat($songTime), "00:00:01", "Time at 1 sec");
    is( posFormat($cycleTime), "00:00:01", "Cycle at 1 sec");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1709000);
    is( $track, "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)", , "track at 1709 sec");
    is( posFormat($songTime), "00:28:29", "Time at 1709 sec");
    is( posFormat($cycleTime), "00:28:29", "Cycle at 1 sec");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1709362);
    is( $track, "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)", , "track at 1709.362 sec");
    is( posFormat($songTime), "00:28:29", "Time at 1709.362 sec");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1709363);
    is( $track, "Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)", , "track at 1709.363 sec");
    is( posFormat($songTime), "00:00:00", "Time at 1710 sec");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1709363);
    is( $track, "Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)", , "track at 1709.363 sec");
    is( posFormat($songTime), "00:00:00", "Time at 1709.363 sec");

    ($track, $songTime, $cycleTime) = $pl->playingAt(1800000);
    is( $track, "Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)", , "track at 1800 sec");
    is( posFormat($songTime), "00:01:30", "Time at 1800 sec");

    ($track, $songTime, $cycleTime) = $pl->playingAt(24*3600*1000);
    is( $track, "Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)", , "track at 1 day");
    is( posFormat($songTime), "00:21:56", "Time at 1 day");
    is( posFormat($cycleTime), "00:50:25", "Cycle at 1 day");

    ($track, $songTime, $cycleTime) = $pl->playingAt(30*24*3600*1000);
    is( $track, "Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)", , "track at 30 day");
    is( posFormat($songTime), "00:09:23", "Time at 30 day");
    is( posFormat($cycleTime), "02:03:18", "Cycle at 30 day");

    done_testing;
}
