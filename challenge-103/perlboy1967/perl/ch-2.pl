#!/usr/bin/perl

# Perl Weekly Challenge - 103
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-103/#TASK2
#
# Task 2 - What’s playing?
#
# Author: Niels 'PerlBoy' van Dijke
#

use v5.16;
use strict;
use warnings;

# Prototypes
sub readPlayList($);

@ARGV = (
  1606134123,
  1614591276,
  'MercuryTheatre.info'
);

my ($START, $CURRENT, $FILE) = @ARGV;

my $elapsedTimeMs = ($CURRENT - $START) * 1000;

printf "start time  : %d (%s)\n", $START, scalar localtime($START);
printf "current time: %d (%s)\n", $CURRENT, scalar localtime($CURRENT);

my ($arPlayList, $playListDurationMs) = readPlayList($FILE);

my $inPlaylistMs = $elapsedTimeMs % $playListDurationMs;

my $i = 0;
while ($inPlaylistMs >= $arPlayList->[$i][0]) {
  $inPlaylistMs -= $arPlayList->[$i++][0];
}
my $inNumberS = int($inPlaylistMs / 1000);

printf "Playing: '%s'\n", $arPlayList->[$i][1];
printf "%02d:%02d:%02d\n", 
      int($inNumberS / 3600),
      int($inNumberS / 60) % 60,
      $inNumberS % 60;


sub readPlayList($) {
  my ($filename) = @_;

  my @playList;
  my $playListDuration = 0;

  if (!open(FH,"< $filename")) {
    die "Can't open '$filename' ($!)";
  } else {
    while (<FH>) {
      s/#.*//;
      if (/^\s*(\d+)\s*,\s*"(.*?)"\s*$/) {
        push(@playList,[$1,$2]);
        $playListDuration += $1;
      }
    }
    close(FH);
  }
  return (\@playList, $playListDuration);
}
