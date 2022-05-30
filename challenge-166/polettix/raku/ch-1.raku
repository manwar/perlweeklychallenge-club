#!/usr/bin/env raku
use v6;
sub MAIN (Int :$max-subs = 8) {
   my $dict = $*PROGRAM.parent.child('../../../data/dictionary.txt');
   put '0x' ~ $_ for hexadecimal-words-from($dict, :$max-subs);
}

sub hexadecimal-words-from($file, :$max-subs) {
   $file.IO.lines.map({hexadecimal-word($_, :$max-subs)}).grep({.defined});
}

sub hexadecimal-word($candidate, :$max-subs is copy = 8) {
   state %HEX-LETTERS = set('abcdef'.comb);
   state %DIGIT-FOR = < o 0 i 1 l 1 s 5 t 7 >;
   my @chars = gather for $candidate.lc.comb -> $char {
      if $char ∈ %HEX-LETTERS { take $char; next }
      return unless %DIGIT-FOR{$char}:exists;
      return if --$max-subs < 0;
      take %DIGIT-FOR{$char};
   }
   return @chars.join('');
}
