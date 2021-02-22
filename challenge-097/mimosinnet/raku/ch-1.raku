# https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/
#   encripted(sentence) = encrpted(words).join
#   encripted(word)     = encripted(letters).join
#   encripted(position) = (position - position_shift) mod alfabet.elems

sub challenge( Str $sentence, Int $left_shift ) {

  my @alphabet = 'A'..'Z';
  my %cipher = @alphabet Z=> @alphabet.rotate: -$left_shift;
  return $sentence.split('', :skip-empty).map({ %cipher{$_} || $_ }).join;
}

multi sub MAIN( Str $sentence, Int $left_shift ) {
  say 'Input: $S = "', $sentence, '", $N = ', $left_shift;
  say 'Output:     "', challenge( $sentence, $left_shift), "\"\n";
}

multi sub MAIN( 'challenge' ) {
  MAIN('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3);
  MAIN('ABCDEFGHIJKLMNOPQRSTUVWXYZ',3);
}

multi sub MAIN( 'test' ) {
  use Test;
  is challenge('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3),'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD';
  is challenge('ABCDEFGHIJKLMNOPQRSTUVWXYZ',3),'XYZABCDEFGHIJKLMNOPQRSTUVW';
}
