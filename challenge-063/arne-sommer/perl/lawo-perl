#! /usr/bin/env perl

use feature 'say';
use feature 'signatures';
no warnings qw(experimental::signatures);

my $verbose = (@ARGV && @ARGV[0] eq "--verbose");

sub last_word ($string, $regex)
{
  say ": String: $string" if $verbose;
  
  for my $word (reverse split(/\s/, $string))
  {
    say ": Word: $word (regex: $regex)" if $verbose;

    return $word if $word =~ $regex;
  }
  return;
}

say last_word('  hello world',                qr/[ea]l/);      # 'hello'
say last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
say last_word("spaces in regexp won't match", qr/in re/);      #  undef
say last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'
