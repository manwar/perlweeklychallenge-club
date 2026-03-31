#!/usr/bin/env perl

# Perl Weekly Challenge 190 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-190/

use Modern::Perl;

$_=shift;
say /^([A-Z]+|[a-z]+|[A-Z][a-z]*)$/ ? 1 : 0;
