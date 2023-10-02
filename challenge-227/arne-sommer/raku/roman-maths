#! /usr/bin/env raku

use lib "lib";

use Number::Roman :to, :from;

unit sub MAIN (Str $first, Str $operator, Str $second);

my $f = from-roman($first);
my $s = from-roman($second);

given $operator
{
  when '+'  { say to-roman($f +  $s) };
  when '-'  { say to-roman($f -  $s) };
  when 'x'  { say to-roman($f *  $s) };
  when '*'  { say to-roman($f *  $s) };
  when 'xx' { say to-roman($f ** $s) };
  when '**' { say to-roman($f ** $s) };
  when '/'  { say to-roman($f / $s) };
  default   { die "unknown operator"; }
}
