#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

open my $fh, '<', $PROGRAM_NAME or die "$OS_ERROR\n";
local $RS = undef;
print <$fh>;
