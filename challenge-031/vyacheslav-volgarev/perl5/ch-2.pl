#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

no strict 'refs';

my $variable_name = shift;

eval ( $$variable_name = 42 );

say $$variable_name;
