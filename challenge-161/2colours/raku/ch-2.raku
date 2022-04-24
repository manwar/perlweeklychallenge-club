#!/usr/bin/env raku

constant $file-url = 'https://raw.githubusercontent.com/manwar/perlweeklychallenge-club/master/data/dictionary.txt';

sub MAIN(
  Str :$load where { ! .defined || .IO.f }, #= local path of the dictionary file to load
  Str :$save #= local path for saving the dictionary
) {
  my @lines;
  with $load {
    @lines = .IO.lines;
  }
  else {
    use HTTP::Tiny;
    @lines = HTTP::Tiny.new.get($file-url)<content>.decode.lines;
  }
  with $save {
    my $f = .IO.open: :w;
    $f.put: @lines.join("\n");
    $f.close;
  }
  # going for the shortest "one letter added only"
  @lines .= sort: *.chars;
  my @solution;
  my $covered-letters = Set.new;
  for @lines -> $current-word {
    if $current-word.comb (-) $covered-letters == 1 {
      @solution.push: $current-word;
      $covered-letters (|)= $current-word.comb;
      last if 'a' .. 'z' ~~ $covered-letters; 
    }
  }
  die 'No solution available.' unless 'a' .. 'z' ~~ $covered-letters;
  @solution.join(' ').say;
}