#!/usr/bin/env perl6
use v6;

for [X] ( 1..10 ) xx 3 {
  .fmt('%2u', '|').say when .sum == 12;
}
