#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

use Array::Utils qw(intersect);

my ($separator, @paths) = (q|/|, ());

# No need $_ to prohibit useless topic
push @paths, chomp && [split /$separator/] while (<DATA>);

# Start with a base path. Compare and find common array elements against
# subsequenty paths.
my $common_path = shift @paths;
@{$common_path} = intersect(@{$common_path}, @{$_}) foreach @paths;

# Display the common prefix paths.
# $ perl ch-2.pl
# /a/b
say join $separator, @{$common_path};

# Note to self:
# __END__ and __DATA__ token cannot mixed within the same file.

1;

__DATA__
/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e
