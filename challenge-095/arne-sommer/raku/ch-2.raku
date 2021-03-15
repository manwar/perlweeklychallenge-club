#! /usr/bin/env raku

unit sub MAIN;

class stack
{
  has @.values is rw;

  method push ($value)
  {
    @.values.push: $value;
  }

  method pop
  {
    return @.values.pop;
  }
  
  method top
  {
    return @.values[0];
  }
  
  method min
  {
    return @.values.min;
  }

  method all
  {
    return @.values.join(" -> ");
  }
}

my $stack = stack.new;

loop
{
  given prompt 'stack> '
  {
    when /^push\s+(.*)$/  { $stack.push: $_ for $0.words; }
    when 'pop'            { $stack.pop; }
    when 'top'            { say $stack.top; }
    when 'min'            { say $stack.min; }
    when 'all'            { say $stack.all; }
    when 'exit' | 'quit'  { exit; }
  }
}
