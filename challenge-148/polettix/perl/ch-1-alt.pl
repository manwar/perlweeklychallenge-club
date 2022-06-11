#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
sub is_eban ($n) { $n !~ m{ [1789] | (?:2\d\z) | (?:[35](?:\d\d)?\z) }mxs }
is_eban($_) && say for 1 .. shift // 100;
