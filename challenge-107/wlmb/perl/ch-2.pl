#!/usr/bin/env perl
# Perl weekly challenge 107
# Task 2: List Methods
#
# See https://wlmb.github.io/2021/04/05/PWC107/#task-2-list-methods
use strict;
use warnings;
use v5.12;

no strict "refs"; # don't be that strict
die 'Use: ./ch-2.pl package [other package] [...]' unless @ARGV;
foreach my $package(@ARGV){
    eval "require $package";
    die $@ if $@;
    foreach my $key(sort keys %{"${package}::"}){
	say $key if defined &{"${package}::$key"};
    }
}
