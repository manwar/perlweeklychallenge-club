sub thirty_three_percent_appearance(@arr)
{
  my %h;
  %h{$_}++ for @arr;
  (%h.keys.grep: {%h{$_} if %h{$_} >= @arr.elems / 3}).min
}

say thirty_three_percent_appearance([1,2,3,3,3,3,4,2]);
say thirty_three_percent_appearance([1,1]);
say thirty_three_percent_appearance([1,2,3]);

