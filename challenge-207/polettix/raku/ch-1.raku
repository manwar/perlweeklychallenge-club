#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { @args.grep(&is-keyboard-word).put }

sub is-keyboard-word ($word) {
   state @rows = < qwertyuiop asdfghjkl zxcvbnm >;
   state @letter-sets = @rows.map({ .comb.Set });
   state %set-idx-for =
      @rows.kv
      .map(-> $idx, $row {
         $row.comb.map(-> $char { $char => $idx }) })
      .flat;

   my @letters = $word.lc.comb;
   my $set-idx = %set-idx-for{@letters[0]};
   my $set = @letter-sets[$set-idx];
   for @letters -> $letter {
      return False if $letter ∉ $set;
   }
   return True;
}
