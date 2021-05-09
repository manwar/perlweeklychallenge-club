# https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/

# words from: https://raw.githubusercontent.com/dwyl/english-words/master/words_dictionary.json

sub challenge( Int $last ) {
  return 'words_dictionary.txt'.IO
    .words
    .grep({ $_ if $_ eq $_.split('',:skip-empty).sort.join })
    .sort({ .chars, .Str })
    .tail( $last );
}

multi sub MAIN( Int $last ) {
  say "The $last longest English words that don’t change when their letters are sorted are: ",challenge($last).Str;
}

multi sub MAIN( 'challenge' ) {
  MAIN(10);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;
  is challenge(10), <knotty adelops alloquy beefily begorry belloot billowy deglory egilops aegilops>;
  done-testing;
}
