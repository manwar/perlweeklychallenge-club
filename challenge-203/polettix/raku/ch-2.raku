#!/usr/bin/env raku
use v6;
sub MAIN ($from, $to) { copy-directory($from, $to) }

sub copy-directory (IO::Path() $from, IO::Path() $to) {
   for $from.dir -> $source {
      next unless $source.d;
      my $target = $to.child($source.basename).mkdir($source.mode);
      samewith($source, $target);
   }
}
