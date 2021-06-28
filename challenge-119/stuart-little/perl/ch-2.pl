#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub nxt($str) {
    $str =~ /(.*)([^3])(3*)$/;
    return (length $2) ? ($1 . ($2+1) . substr('12' x length($3),0,length($3))) : (substr('12' x length($str), 0, length($str)+1));
}

my $out=0;
for (1..$ARGV[0]) {
    $out=nxt($out);
}
say $out;
