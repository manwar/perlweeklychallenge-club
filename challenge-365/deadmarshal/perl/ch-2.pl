#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub valid_token_counter{
  scalar grep {/^(?:[a-z]+-)?[a-z]+[?!.,]?$/} split /\s+/,$_[0];
}

is valid_token_counter("cat and dog"),3,'Example 1';
is valid_token_counter("a-b c! d,e"),2,'Example 2';
is valid_token_counter("hello-world! this is fun"),4,'Example 3';
is valid_token_counter("ab- cd-ef gh- ij!"),2,'Example 4';
is valid_token_counter("wow! a-b-c nice."),2,'Example 5';

