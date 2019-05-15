#! /usr/bin/env perl6

sub MAIN (*@strings)
{
  .say for center(@strings);
}

sub center (@strings)
{
  my $max-length = @strings>>.chars.max;
  return @strings.map({ .indent(($max-length - .chars) / 2) });
}
