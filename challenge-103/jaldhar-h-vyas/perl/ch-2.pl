#!/usr/bin/perl
use 5.40.1;
use warnings;
use English;

my ($start, $current, $csv) = @ARGV;

open my $fh, $csv or die "$OS_ERROR\n";
local $RS = undef;
my @streams = map { [ split q{,} ] } split "\n", <$fh>;
close $fh;

my $elapsed = ($current - $start) * 1000;
my $runtime = 0;

LOOP: while(true) {
    for my $stream (@streams) {
        my ($length, $description) = @{$stream};
        if ($elapsed >= $runtime && $elapsed <= $runtime + $length) {
            say $description;
            my $position = int (($elapsed - $runtime) / 1000);
            say sprintf('%02d:%02d:%02d', int($position / 3600),
                int(($position % 3600) / 60), $position % 60);
            last LOOP;
        }
        $runtime += $length;
    }
}

