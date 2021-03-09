#!/usr/bin/env raku

my $start = 1606134123;

say what's-playing($start, $start+1708, "filelist.csv");
say what's-playing($start, $start+1709, "filelist.csv");
say what's-playing($start, $start+1710, "filelist.csv");
say what's-playing($start, $start+1711, "filelist.csv");
say what's-playing($start, $start+1712, "filelist.csv");

sub what's-playing($start is copy, $current, $file)
{
    for $file.IO.lines -> $line 
    {
        my ($t, $f) = $line.split(",", 2);
        $t /= 1000;
        $start += $t;

        if $start >= $current 
        {
           my $pos = $t - ($start - $current);
           return $f ~ "\n" ~ DateTime.new($pos).hh-mm-ss;
        }
    }
}
