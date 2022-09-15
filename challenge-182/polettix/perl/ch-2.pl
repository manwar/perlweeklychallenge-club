#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'reduce';

say common_path(
   qw<
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl
   >
);

sub common_path (@paths) {
   my $retval = reduce {{
      my @common;
      for my $i (0 .. $a->$#*) {
         last if $i > $b->$#*;
         last if $a->[$i] ne $b->[$i];
         push @common, $a->[$i];
      }
      \@common;
   }} map { my @parts = split m{/}mxs; pop @parts; \@parts } @paths;
   return join '/', $retval->@*;
}
