#! /usr/bin/env raku

unit sub MAIN (UInt :c(:$count) where $count > 0;
               *@numbers where @numbers.elems > 0 && all(@numbers) eq "0" | "1",
               :v(:$verbose));

my @num      = @numbers.clone;  # Cannot assign to an immutable value
my $size     = @num.elems;
my $replaced = 0;

for ^$count
{
  for 0 .. $size -3 -> $start
  {
    print ":Start at $start. Values: [{ @num[$start .. $start +2].join(",") }]" if $verbose;

    if all(@num[$start .. $start +2]) == 0
    {
      @num[$start +1] = 1;
      say " -> replaced with [@num[$start],1,@num[$start+2]]" if $verbose;
      $replaced++;
      last;
    }
    elsif $verbose
    {
      say "";
    }
  }
}

say ":Numbers: { @num.join(",") }" if $verbose;

say + ($count == $replaced);

# $ ./number-placement -v -c=1 1 0 0 0 1
# $ ./number-placement -v -c=2 1 0 0 0 1
# $ ./number-placement -v -c=3 1 0 0 0 0 0 0 0 1
