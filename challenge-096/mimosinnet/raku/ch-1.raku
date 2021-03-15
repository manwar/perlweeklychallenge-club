=begin comment
Perl Weekly Challenge 
https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/

TASK #1 › Reverse Words
Submitted by: Mohammad S Anwar
You are given a string $S.

Write a script to reverse the order of words in the given string. The string may contain leading/trailing spaces. The string may have more than one space between words in the string. Print the result without leading/trailing spaces and there should be only one space between words.

Example 1:
Input: $S = "The Weekly Challenge"
Output: "Challenge Weekly The"
Example 2:
Input: $S = "    Perl and   Raku are  part of the same family  "
Output: "family same the of part are Raku and Perl"

=end comment

#|
sub challenge( $sring ) {
  return $sring.words.reverse;
}

multi sub MAIN( Str $string ) {
  say "Input: \$S = $string";
  say "Output: " ~ challenge($string);
}

multi sub MAIN( 'challenge' ) {
  MAIN("The Weekly Challenge" );
  MAIN("    Perl and   Raku are  part of the same family  ");
}

multi sub MAIN( 'test' ) {
  use Test;
  is challenge("The Weekly Challenge"), "Challenge Weekly The";
  is challenge("    Perl and   Raku are  part of the same family  "), "family same the of part are Raku and Perl";
}
