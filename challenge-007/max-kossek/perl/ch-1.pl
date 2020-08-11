#!/usr/bin/perl;
use strict;
use warnings;

print join "\n", grep { $_ % ((($_ % 10) / 1) + ($_ / 10)) == 0 } 1..50;

__END__
