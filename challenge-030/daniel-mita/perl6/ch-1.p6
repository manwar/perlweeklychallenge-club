#!/usr/bin/env perl6
use v6;

enum Days «
  :1Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
    Sunday
»;

sub MAIN (Bool :$extra) {
  my @extra = "\nExtra:";

  for 2019 .. 2100 -> $year {
    given Date.new( :$year, :12month, :25day ) {
      if .day-of-week == 7 { .say }
      when $extra { push @extra, "$_ is {Days(.day-of-week)}" }
    }
  }

  # I misread the task at first but decided to keep the code for it
  if $extra {
    .say for @extra;
  }
}
