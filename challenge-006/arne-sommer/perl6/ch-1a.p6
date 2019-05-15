unit sub MAIN (Str $values);

my @values = $values.split(",");

die "Integers only!" if @values.grep(/\D/);
die "Wrong order!"   unless [<] @values;

my $result := gather                       # [1]
{
  my @current = @values.shift;

  while @values
  {
    my $next = @values.shift;
    if $next == @current[* -1] + 1
    {
      @current.push($next);
    }
    else
    {
      take fix-it(@current);               # [2]
      @current = $next;
    }
  }

  take fix-it(@current) if @current.elems; # [3]
}

say $result.join(",");                     # [4]

multi sub fix-it (@list where @list.elems == 1)  # [5]
{
  return @list[0];
}

multi sub fix-it (@list where @list.elems == 2)  # [5]
{
  return "@list[0],@list[1]";
}

multi sub fix-it (@list where @list.elems  > 2)  # [5]
{
  return "@list[0]-@list[*-1]";
}

__END__
[1] We use «gather» (with binding; «:=») to set up the supply of values, as a lazy data structure (where the values are only calculated when actually needed).

[2] We use «take» to deliver a value to the consuming part of the program.

[3] A final «take», if we have any values left in the pipeline.

[4] Calling «$result» like this fetches all the values at the same time.

[5] I have chosen Multiple dispatch with «multi sub» and different signatures instead of the «if» conditions in the original version.
