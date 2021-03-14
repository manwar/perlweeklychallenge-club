#!/usr/bin/perl
# 
# Task 2: "What's playing?
# Submitted by: Albert Croft
# 
# Working from home, you decided that on occasion you wanted some background
# noise while working. You threw together a network streamer to continuously
# loop through the files and launched it in a tmux (or screen) session,
# giving it a directory tree of files to play. During the day, you connected
# an audio player to the stream, listening through the workday, closing
# it when done.
# 
# For weeks you connect to the stream daily, slowly noticing a gradual drift
# of the media. After several weeks, you take vacation. When you return,
# you are pleasantly surprised to find the streamer still running. Before
# connecting, however, if you consider the puzzle of determining which
# track is playing.
# 
# After looking at a few modules to read info regarding the media, a
# quick bit of coding gave you a file list. The file list is in a simple
# CSV format, each line containing two fields: the first the number of
# milliseconds in length, the latter the media's title (this example is
# of several episodes available from the MercuryTheatre.info):
# 
#    1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
#    1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
#    1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
#    1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
#    1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
#    1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
#    1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"
# 
# For this script, you can assume to be provided the following information:
# 
#     * the value of $^T ($BASETIME) of the streamer script,
#     * the value of time(), and
#     * a CSV file containing the media to play consisting of the length
#       in milliseconds and an identifier for the media (title, filename,
#       or other).
# 
# Write a program to output which file is currently playing. For purposes
# of this script, you may assume gapless playback, and format the output
# as you see fit.
# 
# Optional: Also display the current position in the media as a time-like value.
# 
# Example:
# UPDATED: Input parameters as reported by many members [2021-03-08 16:20 UK TIME].
# 
# Input: 3 command line parameters: start time, current time, file name
# 
#     # starttime
#     1606134123
# 
#     # currenttime
#     1614591276
# 
#     # filelist.csv
# 
# Output:
# 
#     "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
#     00:10:24
# "
# 
# My notes: ok.  So basically compute currduration=1000*(currenttime-starttime)
# (in milliseconds) and then remove any number of complete song-cycles from
# that, and then work out which song should be playing.  Note that song
# lengths in the CSV file are in milliseconds, and every millisecond counts.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;
use Text::CSV qw(csv);
use List::Util qw(sum);

#
# my $fmt = formatms($ms);
#	Format milliseconds $ms as something
#	nicer, eg 0h10m5s..  return the formatted string.
#
fun formatms( $ms )
{
	my $t = int($ms/1000);

	my $s = $t % 60;
	$t = int($t/60);
	my $result = sprintf( "%02d", $s );

	my $m = $t % 60;
	$t = int($t/60);
	$result = sprintf( "%02d:$result", $m );
	#return $result if $t==0;

	$result = sprintf( "%02d:$result", $t );
	return $result;
}



my $debug=0;
die "Usage: whats-playing [--debug] STARTTIME CURRTIME CSVFILENAME\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==3;

my( $starttime, $currtime, $csvfilename ) = @ARGV;

die "whats-playing: starttime $starttime must be <= $currtime\n"
	if $starttime > $currtime;

my $t = 1000*($currtime-$starttime);

say "debug: starttime=$starttime, currtime=$currtime, t=$t (".formatms($t).")"
	if $debug;

my $aop = csv( in => $csvfilename );

# aop is an array of [ $duration, $title ] pairs
# with all durations in milliseconds

if( $debug )
{
	foreach my $pair (@$aop)
	{
		my $fmt = formatms($pair->[0]);
		say "$fmt, $pair->[1]";
	}
}

# find whole cycle length: sum of durations
my $cycleduration = sum( map { $_->[0] } @$aop );

say "cycleduration: $cycleduration (".formatms($cycleduration).")" if $debug;

# bring $t into the current cycle
$t %= $cycleduration;

say "t: $t (".formatms($t).")" if $debug;

# find which song $t is in..
my $songno = 0;
for(;;)
{
	my $d = $aop->[$songno]->[0];
last if $t < $d;
	$t -= $d;
	$songno++;
}

say "$aop->[$songno]->[1]";
say "time within song: ".formatms($t+1);
