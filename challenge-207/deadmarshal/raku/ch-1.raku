#!/usr/bin/env raku

sub keyboard-word(@arr)
{
  my $s1 = set <q w e r t y y u i o p>;
  my $s2 = set <a s d f g h j k l>;
  my $s3 = set <z x c v b n m>;
  my @ret;
  @arr = @arr>>.lc;
  for @arr -> $word {
    for $s1,$s2,$s3 -> $set {
      if ($word.comb ⊆ $set) {
	@ret.push($word);
      }
    }
  }
  @ret;
}

say keyboard-word(["Hello", "Alaska", "Dad", "Peace"]);
say keyboard-word(["OMG", "Bye"]);
