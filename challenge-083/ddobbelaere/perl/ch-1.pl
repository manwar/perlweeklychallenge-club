#!/usr/bin/perl

=pod
TASK #1 › Words Length
Submitted by: Mohammad S Anwar

You are given a string $S with 3 or more words.

Write a script to find the length of the string except the first and last words ignoring whitespace.
=cut

use v5.30;
use warnings;
use utf8::all;

sub count_inner_chars {
    my ($S) = @_;
    my @a   = split /\s+/, $S;
    length join '', splice @a, 1, -1;
}

if (@ARGV) {

    # Console interface.
    say count_inner_chars("@ARGV");
}
else {
    say "Usage: perl $0 <list of words>";
    exit 1;
}
