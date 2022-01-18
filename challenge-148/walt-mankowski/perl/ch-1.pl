#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.34);
use experimental qw(signatures);
use Lingua::EN::Numbers qw(num2en);

my @eban = grep { num2en($_) !~ tr/e// } 1..100;
local $" = ", ";
say "@eban are the Eban numbers <= 100";
