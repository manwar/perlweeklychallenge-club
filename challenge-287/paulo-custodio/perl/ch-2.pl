#!/usr/bin/env perl

# Perl Weekly Challenge 287 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-287/

use Modern::Perl;

$_ = shift // "";
say /^ [-+]?
       (?: \d+ \. \d* |
           \d* \. \d+ |
           \d+
       )
       (?: e [-+]? \d+ )?
    $/ix ? "true" : "false";
