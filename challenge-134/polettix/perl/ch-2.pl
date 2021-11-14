#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub distinct_terms_count ($m = 3, $n = 5) {
   my $width          = length($n * $m);
   my $idx_width      = length($m);
   my $data_formatter = sub ($first, @rest) {
      join ' ', sprintf("%${idx_width}d", $first),
        map { sprintf "%${width}d", $_ } @rest;
   };
   my @lines;
   push @lines,
     sprintf("%${idx_width}s | ", 'x') . $data_formatter->(1 .. $n);
   push @lines,
     ('-' x $idx_width) . '-+-'
     . ('-' x (length($lines[0]) - 3 - $idx_width));
   my %distinct;
   for my $r (1 .. $m) {
      push @lines, sprintf("%${idx_width}d | ", $r) . $data_formatter->(
         map {
            $distinct{my $p = $r * $_} = 1;
            $p;
         } 1 .. $n
      );
   } ## end for my $r (1 .. $m)
   return {
      table    => join("\n", @lines),
      distinct => [sort { $a <=> $b } keys %distinct],
   };
} ## end sub distinct_terms_count

say '';
my $outcome = distinct_terms_count(@ARGV);
say $outcome->{table} =~ s{^}{      }rgmxs;
say '';
say 'Distinct Terms: ', join ', ', $outcome->{distinct}->@*;
say 'Count: ', scalar($outcome->{distinct}->@*);
