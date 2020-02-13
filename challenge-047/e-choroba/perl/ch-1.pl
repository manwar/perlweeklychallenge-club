#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use lib '.';
use MyRoman qw{ to_roman from_roman }; # Extracted from PWC010/1.

my ($n1, $op, $n2) = @ARGV;
my $function = { '+' => sub { $_[0] + $_[1] },
                 '-' => sub { $_[0] - $_[1] },
                 '*' => sub { $_[0] * $_[1] },
                 '/' => sub { int($_[0] / $_[1]) }
               }->{$op}
    or die "Unknown operator $op.";
say to_roman($function->(map from_roman($_), $n1, $n2));
