use strict; use warnings; use Test::More tests => 5;

sub closest_palindrome {
  my($n, $jump) = (@_, -1);
  $n += $jump;
  $n =~ /^((.)(?1)\2|.?)$/ ? $n : closest_palindrome( $n, -$jump + 1 - 2 * ($jump > 0) )
}

is closest_palindrome(123)     => 121;
is closest_palindrome(2)       => 1;
is closest_palindrome(1400)    => 1441;
is closest_palindrome(1001)    => 999;
is closest_palindrome(3700000) => 3699963;

#https://theweeklychallenge.org/blog/perl-weekly-challenge-288/
#https://stackoverflow.com/questions/22349358/finding-palindrome-using-regex
