#! /usr/bin/env raku

my @stack;

multi sub MAIN (:$verbose)
{
  loop
  {
    my $input = prompt "> ";

    parse($input, $verbose);
  }
}

multi sub MAIN (Str $args, :$verbose)
{
  for $args.words -> $word
  {
    $word.Numeric
      ?? parse($word.Numeric, $verbose)
      !! parse($word, $verbose);
  }
}

sub parse ($input, $verbose)
{
  if $input ~~ Numeric
  {
    stack-push($input, $verbose);
  }
  elsif $input eq any( <* / + - ^> )
  {
    my $result = calculate($input, $verbose);
    say ": - Result: $result" if $verbose;
    stack-push($result, $verbose);
  }
  elsif $input eq "="
  {
    @stack.elems
       ?? say @stack.pop
       !! say "Error. Not enough values on the stack";
  }
  elsif $input eq "s"
  {
    say @stack.join(", ");
  }
  elsif $input eq "h"
  {
    say 'Enter a number, an operator (* / + - ** div %), = (show the value), s (show the stack)';
  }
  else
  {
    say "Illegal input ($input). Use 'h' for help";
  }
}

sub stack-push ($value, $verbose)
{
  @stack.push: $value;
  if $verbose
  {
    say ": - Add to stack: $value";
    say ": Stack: { @stack.join(", ") }";
  }
}

sub calculate ($operator, $verbose)
{
  if @stack.elems < 2
  {
    say "Error. Not enough values on the stack";
    return;
  }

  my $right = @stack.pop;
  my $left  = @stack.pop;
  
  if $verbose
  {
    say ": Operator: $operator";
    say ": - Stack: { @stack.join(", ") }";
    say ": - Values: $left $right";
  }
  
  return $left -  $right if $operator eq "-";
  return $left +  $right if $operator eq "+";
  return $left /  $right if $operator eq "/";
  return $left *  $right if $operator eq "*";
  return $left ** $right if $operator eq "^";

  die "Unknown operator";
}
