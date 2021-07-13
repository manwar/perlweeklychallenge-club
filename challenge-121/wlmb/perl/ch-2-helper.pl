#!/usr/bin/env perl
# Perl weekly challenge 121
# Task 2: The travelling salesman. Auxiliary program
#
# See https://wlmb.github.io/2021/07/12/PWC121/#task-2-the-travelling-salesman
use strict;
use warnings;
use v5.12;
use PDL;
foreach(@ARGV){
    my $m=random($_,$_);
    $m->diagonal(0,1).=0; # zero the diagonal
    $m= ($m+$m->transpose)/2; #symmetrize (?)
    # Format:
    print "\'[", join(',', map {'['. join(',', @$_).']'} @{unpdl $m}), "]\' ";
}
