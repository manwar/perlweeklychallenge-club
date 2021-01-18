=begin comment
Perl Weekly Challenge 
https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/

095-1: Palindrome Number

You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.

Example 1:
Input: 1221
Output: 1

Example 2:
Input: -101
Output: 0, since -101 and 101- are not the same.

Example 3:
Input: 90
Output: 0

=end comment

class Palindrome {
  has Int $.num;

  method is_palindrome() {
    return 0 unless $.num.chars %% 2;
    return 0 if $.num < 0;
    my @digits = $!num.Str.split('');

    while @digits.elems {
      return 0 if @digits.shift ne @digits.pop;
    }
    return 1;
  }
}

multi sub MAIN( Int $num ) {
  say "\nInput:  " ~ $num;
  say 'Output: ' ~ Palindrome.new( num => $num ).is_palindrome;
}

multi sub MAIN( 'challenge' ) {
  <1221 -101 90>.map: { MAIN( .Int ) };
}

multi sub MAIN( 'test' ) {
  use Test;

  my %test = 1221 => 1, -101 => 0, 90 => 0, 123321 => 1, 10100101 => 1 ;
  for %test.keys {
    is( 
      Palindrome.new( num => $_.Int ).is_palindrome,
      %test{$_}
    );
  }
 
}
