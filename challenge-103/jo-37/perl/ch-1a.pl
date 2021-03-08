#!/usr/bin/perl

use v5.16;
use warnings;

die <<EOS unless @ARGV;
usage: $0 word ...

word ...
    words to encode

EOS

# ./ch-1a.pl metal water wood fire earth
# ./ch-1a.pl monkey rooster dog pig rat ox tiger rabbit dragon snake horse goat

use constant A => ord('a');

my $buf;
for (@ARGV) {
    my $wbuf;
    for (split //) {
        $wbuf .= sprintf "%02d", ord() - A;
    }
    $buf .= sprintf "%02d%s", 2 * length, $wbuf;
}
printf "%04d%s\n", length($buf), $buf;
