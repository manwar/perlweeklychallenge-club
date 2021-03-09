#!/usr/bin/env raku

say what's-playing(1606134123, 1606134123+1708, "filelist.csv");
say what's-playing(1606134123, 1606134123+1709, "filelist.csv");
say what's-playing(1606134123, 1606134123+1710, "filelist.csv");
say what's-playing(1606134123, 1606134123+1711, "filelist.csv");
say what's-playing(1606134123, 1606134123+1712, "filelist.csv");

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
           return $f ~ "\n" ~ DateTime.new(Instant.from-posix($pos)).hh-mm-ss;
        }
    }
}
