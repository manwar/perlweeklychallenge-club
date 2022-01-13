#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $s = $ARGV[0] // exit;

$s =~ /^[0-9\(\)\+\-\*\s]+$/
    ? say eval($s)
    : say "Error";
