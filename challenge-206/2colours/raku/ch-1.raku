#!/usr/bin/env raku


my token time-hours24 { \d ** 2 <?{$/ < 24}> }
my token time-minutes { \d ** 2 <?{$/ < 60}> }
my token time-o-clock { <time-hours24> ':' <time-minutes> }
my token time-list {^ '(' ['"' <time-o-clock> '"'] ** 2..* % ',' ')' $}

sub infix:<t->($lhs is copy, $rhs is copy) {
  $_ = .split(':').&{ .[0] * 60 + .[1]} for ($lhs, $rhs);
  ($lhs - $rhs) % 1440
}

sub MAIN($_) {
  die 'Please provide a valid list of HH:MM times' unless S:g/\s// ~~ &time-list;
  given my Str() @time = $<time-o-clock> {
    .=sort;
    .push: .head;
  }
  say @time;
  @time
    .rotor: 2 => -1 andthen
    .map: { .[1] t- .[0] } andthen
    .min
    .say;
}