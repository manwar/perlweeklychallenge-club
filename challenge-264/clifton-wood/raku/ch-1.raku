sub greatest ($str) {
  my @uc = ('A'...'Z');
  my @lc = ('a'...'z');

  my @ucm = ( $str ~~ m:g/@uc/ ).map( *.Str ).unique;
  my @lcm = ( $str ~~ m:g/@lc/ ).map( *.Str ).unique;

  my @s = @lcm.map({ [ .uc, @ucm.first(.uc, :k), @uc.first( .uc, :k ) ] }).grep( *[1].defined ).sort( *.tail );

  unless +@s {
    say "There is no greatest letter.";
    return;
  }

  say "There are {@s.elems} letters that are both upper and lower: { @s.map( *.head ).join(', ') }";
  say "The greatest letter is then: { @s.tail.head }"
}

greatest('PeRlwEeKLy');
# There are 2 letters that are both upper and lower: E, L
# The greatest letter is then: L

greatest('ChaLlenge');
# There are 1 letters that are both upper and lower: L
# The greatest letter is then: L

greatest('The');
# There is no greatest letter.
