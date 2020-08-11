#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-11-13
# Week: 034
# Task #2
# Contributed by Dave Cross
# Write a program that demonstrates a dispatch table.

use strict;
use warnings;
use feature qw/ say /;

my %dispatch_table = (
    0 => \&bop_it,
    1 => \&twist_it,
    2 => \&bash_it,
    3 => \&pull_it,
    4 => \&flick_it,
    5 => \&spin_it,
    6 => \&shake_it,
    7 => \&try_harder,
);

sub bop_it     { say "Bob it!" }
sub twist_it   { say "Twist it!" }
sub bash_it    { say "Bash it!" }
sub pull_it    { say "Pull it!" }
sub flick_it   { say "Flick it!" }
sub spin_it    { say "Spin it!" }
sub shake_it   { say "Shake it!" }
sub try_harder { say "Try harder!" }

$dispatch_table{ int( rand(8) ) }->();

