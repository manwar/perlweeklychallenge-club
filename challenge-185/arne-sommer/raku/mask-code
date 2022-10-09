#! /usr/bin/env raku

my regex a9 { <[0..9 a..z]> };

my @list1 = ('ab-cde-123', '123.abc.420', '3abc-0010.xy');
my @list2 = ('1234567.a',  'a-1234-bc',   'a.b.c.d.e.f');

say mask-code(@list1);
say mask-code(@list2);

sub mask-code (@list)
{
  my @return;

  for @list -> $string is copy
  {
    my $count = 0;

    for ^$string.chars -> $index
    {
      # say ": $string + $index -> { $string.substr($index,1) } C:$count";

      if $string.substr($index,1) ~~ /^ <a9> $/
      {
        $string.substr-rw($index,1) = "x";
        $count++;
	last if $count == 4;
      }
    }
    @return.push: $string;
  }

  return @return;
}
