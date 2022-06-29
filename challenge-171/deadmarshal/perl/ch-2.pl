#!/usr/bin/env perl
use strict;
use warnings;

my $f = sub{shift() + 2};
my $g = sub{shift() * 2};

sub compose{
  my ($f, $g) = @_;
  sub {
    $f->($g->(shift()));
  }
}

print compose($f, $g)->(5);
