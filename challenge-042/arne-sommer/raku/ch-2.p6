#! /usr/bin/env raku

unit sub MAIN (:$maxchars = 6, :$iterations = 10, :$color);

sub brackets ($count = (1 .. $maxchars).pick)
{
  return (^$count).map({ <( )>.pick }).join;
}

sub is-balanced ($brackets)
{
  return False if $brackets.chars % 2; # An odd number
  return False if $brackets.substr(0,  1) eq ')';
  return False if $brackets.substr(*-1,1) eq '(';

  my $count = 0;

  for $brackets.comb -> $char
  {
    if    $char eq '(' { $count++; }
    elsif $char eq ')' { $count--; }
    else { die "Illegal character $char"; }
    
    return False if $count < 0; # Unbalanced inside
  }
  
  return $count == 0;
}

for ^$iterations
{
  my $brackets = brackets;

  $color
    ?? say "$brackets - { is-balanced($brackets) ?? "\x1b[42m" ~ "OK" !! "\x1b[41m" ~ "NOT OK" }" ~ "\x1b[0m"
    !!  say "$brackets - { is-balanced($brackets) ?? "OK" !! "NOT OK" }";
}
