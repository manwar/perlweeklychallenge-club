#!/usr/bin/env perl6
use v6;

# run <script> <start time as unix epoch> <current time as unix epoch> <path-to-csv>

sub fromCSV($path) {
    $path.IO.lines.map(*.split(',')).map( -> ($t,$f) {$t.Int,$f})
}

sub totPlayTime(@files) {
    @files.map(*.head).sum
}

sub cvToTime($millisecs) {
    my $totSecs=($millisecs/1000).round;
    my $s = $totSecs % 60;
    my $m = ($totSecs div 60) % 60;
    my $h = ($totSecs - $m*60 - $s) div 60**2;
    return ($h,$m,$s);
}

sub whichPlaying($tdiff,@files) {
    ($tdiff <= @files[0].head) && return @files[0].tail;
    return whichPlaying($tdiff - @files[0].head, @files[1..*]);
}

sub wherePlaying($tdiff,@files) {
    cvToTime($tdiff % @files.&totPlayTime)
}

my @files = fromCSV(@*ARGS[2]);
my $tdiff = (@*ARGS[1].Int-@*ARGS[0].Int)*1000 % @files.&totPlayTime;

my ($h,$m,$s) = wherePlaying($tdiff,@files);
my $playingFile = whichPlaying($tdiff,@files);

say qq|\nPlaying: $playingFile\n\nAt: $h:$m:$s|;
