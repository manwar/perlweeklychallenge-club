# https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/

class Read-Chars {

  has $!content;
  has $!pointer;

  submethod TWEAK {
    $!content = 'input.txt'.IO.slurp.chomp;
    $!pointer = 0;
  }

  method read-chars ( $chars ) {
    my $string = substr($!content,$!pointer,$chars);
    $!pointer = $!pointer + $chars;
    $!pointer = $!content.chars if $!pointer > $!content.chars;
    return $string;
  }

}

multi sub MAIN( 'challenge' ) {
  my $read = Read-Chars.new;
  say 'Input: Suppose the file (input.txt) contains "1234567890"';
  say 'Output:';
  say "\tprint readN(\"input.txt\", 4): " ~ $read.read-chars(4);
  say "\tprint readN(\"input.txt\", 4): " ~ $read.read-chars(4);
  say "\tprint readN(\"input.txt\", 4): " ~ $read.read-chars(4);
}

multi sub MAIN( 'test' ) {
  use Test;

  my $read = Read-Chars.new;
  is $read.read-chars(4), '1234';
  is $read.read-chars(4), '5678';
  is $read.read-chars(4), '90';
}
