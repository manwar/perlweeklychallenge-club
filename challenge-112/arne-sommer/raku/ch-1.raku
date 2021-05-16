#! /usr/bin/env raku

unit sub MAIN (Str $path where $path.substr(0,1) eq '/', :v($verbose)); 

my @path = $path.split('/');

@path.shift;

my @result;

for @path -> $current
{
  say ":: current element $current" if $verbose;
  
  next unless $current;
  next if $current eq '.';

  if $current eq '..'
  {
    @result.pop;
  }
  else
  {
    @result.push: $current;
  }
}

say "/{ @result.join('/') }";
