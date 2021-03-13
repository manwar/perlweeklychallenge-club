#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 103
#               Task 1 - What's Playing?
#
#       AUTHOR: Lubos Kolouch 
#      CREATED: 03/13/2021 11:06:43 AM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

sub now_playing {
    my $what = shift;

    open my $file, '<', $what->{filename};

    my %tracks;
    my $total_length = 0;
    my $track = 0;
    while (<$file>) {
        chomp;

        my ($len, $title) = split /,/, $_;

        $tracks{$track}{'track_start'} = $total_length;
        $tracks{$track}{'len'} = $len;
        $tracks{$track}{'title'} = $title;
        $total_length += $len;
        $tracks{$track}{'total_length'} = $total_length;
        $track++;
    }

    # damned miliseconds, took me long debugging to notice them
    my $diff = ($what->{now} - $what->{start})*1000;
    $diff %= $total_length;

    $track = 0;
    $track++ while $tracks{$track}{'total_length'} <= $diff;

    my $track_pos = int(($diff - $tracks{$track}{'track_start'})/1000);

    my $hour = int($track_pos / 3600);
    my $min = int(($track_pos - $hour*60) / 60);
    my $sec = $track_pos - $min*60;

    return "$tracks{$track}{'title'} at $hour:$min:$sec";
}

use Test::More;
is(now_playing({start => 1606134123, now => 1614591276, filename => 'now_playing.csv'}), '"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)" at 0:10:24');

done_testing;
