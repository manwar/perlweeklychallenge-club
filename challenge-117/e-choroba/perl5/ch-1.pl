#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $MAX_NUMBER = 15;

my %expected;
@expected{1 .. $MAX_NUMBER} = ();
delete $expected{ (/^([0-9]+)/)[0] } while <>;
say for keys %expected;
