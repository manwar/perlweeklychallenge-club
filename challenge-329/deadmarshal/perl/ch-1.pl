#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use List::Util qw(uniq);

sub counter_integers{
  uniq $_[0] =~ /(\d+)/g
}

print show counter_integers('the1weekly2challenge2');
print show counter_integers('go21od1lu5c7k');
print show counter_integers('4p3e2r1l');

