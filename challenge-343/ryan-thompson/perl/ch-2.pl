#!/usr/bin/env perl

use v5.38;
use List::Util qw< sum max reduce >;

sub best {
    my ($bs,$bi,$s) = (0,0);
    ($s = sum $_[$_]->@*) > $bs and ($bs,$bi)=($s,$_) for 0..$#_;
    $bi;
}
