#!/usr/bin/env raku

use v6.*;
use immutable;
use JSON::Fast;

my $input = prompt '@list = ';
$input .= trim;
when not $input.&{ .starts-with('(') && .ends-with(')')} {
  say 'Please provide a valid list of arrays.'
}
$input .= subst: '(', '[', :1nth;
$input .= subst: ')', ']', :nth(*);
my \try-list = try $input.&from-json;
when not try-list.defined {
  say 'The elements of the list should be valid according to JSON.';
}
when try-list.are !~~ Array {
  say 'The elements should all be arrays.';
}
my @output-arrays <==
  try-list
  .map: &immutable andthen
  .unique
  .map: *.&to-json(:!pretty);
say "(@output-arrays.join(', '))";
