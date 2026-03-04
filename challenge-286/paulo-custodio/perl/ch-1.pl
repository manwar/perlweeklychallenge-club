#!/usr/bin/env perl

# Challenge 286

use Modern::Perl;
use Path::Tiny;
use List::Util 'shuffle';

if (@ARGV) {
    my $n = shift // 0;
    say((split " ", path($0)->slurp)[$n]);
}
else {
    say((shuffle(split " ", path($0)->slurp))[0]);
}
