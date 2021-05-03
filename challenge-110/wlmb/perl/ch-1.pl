#!/usr/bin/env perl
# Perl weekly challenge 110
# Task 2: Valid phone numbers
#
# See https://wlmb.github.io/2021/04/27/PWC110/#task-1-valid-phone-numbers
use strict;
use warnings;
use v5.12;
my $pattern= join '|', map {qr(^\s*$_\s*$)} qw(\+\d{2}\s\d{10} \\(\d{2}\\)\s\d{10} \d{4}\s\d{10});
print "Output:\n", grep {$_=~$pattern} <>;
