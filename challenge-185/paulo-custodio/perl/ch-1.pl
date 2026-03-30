#!/usr/bin/env perl

# Perl Weekly Challenge 185 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-185/

use Modern::Perl;

@ARGV==1 or die "usage: ch-1.pl mac\n";
say $ARGV[0] =~ s/^(\w\w)(\w\w)\.(\w\w)(\w\w)\.(\w\w)(\w\w)$/$1:$2:$3:$4:$5:$6/r;
