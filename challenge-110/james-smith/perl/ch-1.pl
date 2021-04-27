#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

print grep { is_valid_phone_number($_) } <>;

sub is_valid_phone_number {
  return m{\A\s*(?:[+]\d+|00\d+|[(]\d+[)])\s+\d+\s*\Z};
}

