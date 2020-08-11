#! /usr/bin/perl6

my $f=open :r,$*PROGRAM-NAME;
for $f.lines {
  say $_;
}
