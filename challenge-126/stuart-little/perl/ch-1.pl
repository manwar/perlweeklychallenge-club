#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub no1($nr) {
    length($nr)==0 && return 0;
    (substr($nr,0,1) eq '1') && return 9**(length($nr)-1);
    return (int(substr($nr,0,1))-1) * 9**(length($nr)-1) + no1(substr($nr,1));
}

say(($ARGV[0] !~ m/1/) ? (no1($ARGV[0])) : (no1($ARGV[0])-1)) 
