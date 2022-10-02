#! /usr/bin/env raku

my @list1 = ('a 1 2 b 0', '3 c 4 d');
my @list2 = ('1 2', 'p q r', 's 3', '4 5 t');

say split-array(@list1);
say split-array(@list2);

sub split-array (@list)
{
  my @digits;
  my @letters;

  for @list -> $string
  {
    my @d-curr;
    my @l-curr;

    for $string.words -> $char
    {
      $char eq any(0..9) ?? @d-curr.push($char) !! @l-curr.push($char);
    }

    @digits.push: @d-curr  if @d-curr;
    @letters.push: @l-curr if @l-curr;
  }

  return (@digits, @letters);
}
