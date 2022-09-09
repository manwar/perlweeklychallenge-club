#!/usr/bin/env raku
use v6;
sub MAIN { put sentence-order(paragraph()) }

sub sentence-order ($paragraph) {
   return $paragraph.split(/\.(\s*|$)/)
      .map({ .split(/\s+/).sort({ .fc }).join(' ') })
      .join('. ');
}

sub paragraph {
   return q:to/END/;
      All he could think about was how it would all end. There was
      still a bit of uncertainty in the equation, but the basics
      were there for anyone to see. No matter how much he tried to
      see the positive, it wasn't anywhere to be seen. The end was
      coming and it wasn't going to be pretty.
      END
}
