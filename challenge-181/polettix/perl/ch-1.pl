#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say sentence_order(paragraph());

sub sentence_order ($paragraph) {
   $paragraph = join '. ',
      map { join ' ', sort { fc($a) cmp fc($b) } split m{\s+}mxs }
      split m{\.(?:\s+|\z)}mxs, $paragraph;
   return $paragraph . ".\n";
}

sub paragraph {
   return <<'END' =~ s{^\s+}{}rgmxs;
      All he could think about was how it would all end. There was
      still a bit of uncertainty in the equation, but the basics
      were there for anyone to see. No matter how much he tried to
      see the positive, it wasn't anywhere to be seen. The end was
      coming and it wasn't going to be pretty.
END
}
