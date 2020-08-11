#! /usr/bin/env perl6

unit sub MAIN (Int $count where $count > 0 = 1);

use LWP::Simple;
use JSON::Fast;

my $json = LWP::Simple.get('https://www.poemist.com/api/v1/randompoems');

my $data = from-json $json;

for ^$count
{
  last unless $data[$_];

  my $first = '"' ~ $data[$_]<title> ~ '" by ' ~ $data[$_]<poet><name>;
  say $first;  
  say '-' x $first.chars;    
  say $data[$_]<content>;
  say "";
}
