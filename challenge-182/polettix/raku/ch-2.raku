#!/usr/bin/env raku
use v6;
sub MAIN {
   put common-path(<
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl
   >);
}

sub common-path (@paths) {
   @paths».split(/\//)».Array.map({.pop;$_}).reduce({
      my @common;
      for @$^a Z @$^b -> ($a, $b) {
         last if $a ne $b;
         @common.push: $a;
      }
      @common;
   }).join('/');
}
