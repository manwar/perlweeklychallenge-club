#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ sum };

say for grep 0 == $_ % sum(split //), 1 .. 50;
