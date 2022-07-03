#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $h1 = compose(sub { $_[0] + 1 }, sub { $_[0] * 2 });
say $h1->(1);

my $h2 = compose(sub { $_[0] * 2 }, sub { $_[0] + 1 });
say $h2->(1);

sub compose ($f, $g) { sub { $f->($g->(@_)) } }
