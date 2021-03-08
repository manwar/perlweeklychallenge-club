#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <start time as unix epoch> <current time as unix epoch> <path-to-csv>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use POSIX qw(round);

sub fromCSV($path) {
    my @res;
    open(my $fh, "<", $path)
	or die "Failed to open file: $!\n";
    while(<$fh>) {
	chomp;
	my @tf = split(/,/,$_);
	push @res, \@tf;
    }
    return \@res;
}

sub totPlayTime($files) {
    my $sum=0;
    for (@{$files}) {
	$sum+=$_->[0];
    }
    return $sum;
}

sub cvToTime($millisecs) {
    my $totSecs=round($millisecs/1000);
    my $s = $totSecs % 60;
    my $m = (int($totSecs/60)) % 60;
    my $h = int(($totSecs - $m*60 - $s)/60**2);
    return ($h,$m,$s);
}

sub whichPlaying($tdiff,$files) {
    ($tdiff <= $files->[0]->[0]) && return $files->[0]->[1];
    my @rest=$files->@[1..scalar @$files-1];
    return whichPlaying($tdiff - $files->[0]->[0], \@rest);
}

sub wherePlaying($tdiff,$files) {
    cvToTime($tdiff % totPlayTime($files))
}

my @files = @{fromCSV($ARGV[2])};
my $tdiff = ($ARGV[1]-$ARGV[0])*1000 % totPlayTime(\@files);

my ($h,$m,$s) = wherePlaying($tdiff,\@files);
my $playingFile = whichPlaying($tdiff,\@files);

say qq|\nPlaying: $playingFile\n\nAt: $h:$m:$s|;

