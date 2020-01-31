#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;

die "Unable to open file: $!" unless
  open my $fh, '<', $0;
print while <$fh>;

__DATA__

TASK #2
Source Dumper

Write a script that dumps its own source code. For example, say, the script name is ch-2.pl then the following command should returns nothing.

$ perl ch-2.pl | diff - ch-2.pl
