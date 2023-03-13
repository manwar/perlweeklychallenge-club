use Test;

sub extract-keyboard-words (@words where all($_) ~~ Str:D) {
  my @keyboard-rows = (
    Set.new(<q w e r t y u i o p>),
    Set.new(<a s d f g h j k l>),
    Set.new(<z x c v b n m>)
  );

  gather {
    for @words -> $raw-word {
      my $word = lc $raw-word;
      for @keyboard-rows -> %keyboard-row {
        take $raw-word and next if all(%keyboard-row{$word.comb('')});
      }
    }
  }
}

is extract-keyboard-words(["Hello", "Alaska", "Dad", "Peace"]), ["Alaska", "Dad"];
is extract-keyboard-words(["OMG", "Bye"]),                      [];
is extract-keyboard-words(["ABC"]),                             [];
