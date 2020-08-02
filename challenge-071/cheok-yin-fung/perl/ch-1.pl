#!/usr/bin/perl
#
# Perl Weekly Challenge #071 Task 1 Peak Elements
#
# Usage: ch-1.pl $N

use strict;
use warnings;

my $N;
my @seq = ();
my @peak_eles = ();

if ($ARGV[0]) {$N = $ARGV[0];} else {$N = 10;}

for (1..$N) {
   push @seq, 1+int(rand(50))
}

sub checkpeak {
    my $p = $_[0];
    if ($seq[$p-1] < $seq[$p] and $seq[$p+1] < $seq[$p]) {
        push @peak_eles, $seq[$p];
    }
}

for (1..$N-2) {
    checkpeak($_);
}

print "Array: [ ", join ", ", @seq;
print "]\n";
print "Peak: [ ", join ", ", @peak_eles;
print "]\n";
