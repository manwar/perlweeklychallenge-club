#! /usr/bin/env raku

unit sub MAIN (:$verbose);

sub last_word ($string, Regex $regex)
{
  say ": String: $string" if $verbose;
  
  for $string.split(/\s/).reverse -> $word
  {
    say ": Word: $word (regex: { $regex.gist })" if $verbose;

    return $word if $word ~~ $regex;
  }
  return;
}

say last_word('  hello world',                rx/<[ea]>l/);       # 'hello'
say last_word("Don't match too much, Chet!",  rx:i/ch.t/);        # 'Chet!'
say last_word("spaces in regexp won't match", rx:s/in re/);       #  undef
say last_word( join(' ', 1..1e6),             rx/^(3.*?) ** 3 /); # '399933'
