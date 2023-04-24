#!/usr/bin/perl

use v5.16;
use warnings;

no strict 'refs';
my ($name, $value) = @ARGV;
${$name} = $value;
say "\$$name = ${$name}"
