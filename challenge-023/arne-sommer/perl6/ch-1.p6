#! /usr/bin/env perl6

subset Positive of Int where * >= 1;

sub MAIN (Positive :$order = 1, *@list is copy)
{
  die "Integers only in the list!" unless @list.all ~~ Int;
    
  @list = forward-difference(@list) for ^$order;

  say @list;
}

sub forward-difference (@list)
{
  return gather take @list[$_] - @list[$_ -1] for 1 .. @list.end;
}
