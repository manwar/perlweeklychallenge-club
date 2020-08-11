#!/usr/bin/env perl6

unit sub MAIN (
  UInt :$parens = 10,
);

my $count = 0;

for roll <( )>: (^$parens).pick {
  .say;
  when '(' { $count++ }
  when ')' { die 'close before open' if --$count < 0 }
}

if $count {
  die "$count unclosed";
}

'balanced'.say;
