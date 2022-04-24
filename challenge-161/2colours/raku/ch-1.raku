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
  @lines.grep({ .comb.cache andthen $_ Zlt .skip andthen .all.so}).sort(*.chars).reverse.join(', ').say;
}