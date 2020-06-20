#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my $word = $ARGV[0] || 'xyxx';
if ($word =~ /[^xy]/) {
    say "Error: non x|y character detected";
} else {
    my $rot     = 1;
    my $ret     = 1;
    my $hold    = $word;

    while ( ($word = $word =~ s/(^.{$rot})(.*)/$2$1/r) ne $hold ) {
        $rot = ++$ret % length $word
    }

    say $ret
}