#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Define sub last_word($string, $regexp) that returns the last word matching $regexp found in the given string, or undef if the string does not contain a word matching $regexp.
For this challenge, a "word" is defined as any character sequence consisting of non-whitespace characters (\S) only. That means punctuation and other symbols are part of the word.
The $regexp is a regular expression. Take care that the regexp can only match individual words! 
=cut


use Test::More;

is(last_word('  hello world',                qr/[ea]l/),      'hello',  'found <hello>');
is(last_word("Don't match too much, Chet!",  qr/ch.t/i),      'Chet!',  'found <Chet!>');
is(last_word("spaces in regexp won't match", qr/in re/),      undef,    'rejected space');
is(last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/), '399933', 'found <399933>');
is(last_word( join(' ', 1e3.. 2e3 ),         qr/135$/),       '1135',   'found <1135>');
done_testing();

sub last_word
{
     my ($string, $re) = @_; 
     my @words = split(/\s+/, $string); 
     my $match;

     for my $word ( @words )
     {
          if ( $word =~ $re )
          {
               $match = $word;
          }
     }
     return $match;
}





=output
ok 1 - found <hello>
ok 2 - found <Chet!>
ok 3 - rejected space
ok 4 - found <399933>
ok 5 - found <1135>
1..5
=cut