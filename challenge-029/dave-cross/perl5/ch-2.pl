#!/usr/bin/perl

use strict;
use warnings;

use Inline C => <<'END_OF_C';

void hello(char* name) {
  printf("Hello, %s\n", name);
}

END_OF_C

my $name = shift || 'Perl';

hello($name);
