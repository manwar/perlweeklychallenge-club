#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(uniq);

sub common_characters{
  my %count;
  map{$count{$_}++ foreach uniq split '',CORE::fc} @{$_[0]};
  sort grep{$count{$_} == @{$_[0]}} keys %count;
}

printf "%s\n", join ' ', common_characters(["Perl","Rust","Raku"]);
printf "%s\n", join ' ', common_characters(["love","live","leave"]);

