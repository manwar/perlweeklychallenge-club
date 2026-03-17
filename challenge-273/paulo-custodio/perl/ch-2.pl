#!/usr/bin/env perl

# Perl Weekly Challenge 273 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/

use Modern::Perl;

$_ = shift // "";
say /b/ && !/^[^b]*b.*?a/ ? 'true' : 'false';
