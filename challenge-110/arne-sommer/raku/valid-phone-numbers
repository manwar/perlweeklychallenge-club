#! /usr/bin/env raku

unit sub MAIN ($phonebook where $phonebook.IO.f && $phonebook.IO.r = 'phone-numbers.txt');

for $phonebook.IO.lines -> $line
{
  next unless $line.chars == 15;
  next unless $line.substr(4,1) eq ' ';
  next unless $line.substr(5) ~~ /^\d ** 10$/;

  my $first = $line.substr(0,4);

  next unless $first ~~ /^\d ** 4$/ || $first ~~ /^\s\+\d\d$/ || $first ~~ /^\(\d\d\)$/;

  say $line;
}