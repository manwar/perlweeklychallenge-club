unit sub MAIN (Str $values);

my @values = $values.split(",");

die "Integers only!" if @values.grep(/\D/);
die "Wrong order!"   unless [<] @values;

my @result;

my @current = @values.shift;        # [1]

while @values                       # [2]
{
  my $next = @values.shift;         # [2]
  if $next == @current[* -1] + 1
  {
    @current.push($next);           # [3]
  }
  else
  {
    @result.push(fix-it(@current)); # [4]
    @current = $next;               # [4]
  }
}

@result.push(fix-it(@current)) if @current.elems;   # [5]

say @result.join(",");                              # [6]

sub fix-it (@list)                                  # [7]
{
  return @list[0]              if @list.elems == 1; # [8]
  return "@list[0],@list[1]"   if @list.elems == 2; # [9]
  return "@list[0]-@list[*-1]" if @list.elems  > 2; # [10]
}

__END__
[1] We start with the first value (in @current).

[2] And continue as long as there are more values in the list (placed in $next).

[3] If the next value is one after the previuos one (the next integer value), we add it to @current.

[4] If not, the @current array is added to the @result list. And we reset the @current array.

[5] Finally (when we run out of new values), we add the last ones to the @result list.

[6] Add a comma between the value groups.

[7] This procedure fixes a list of (consecutive) integers;

[8] if one integer, print it.

[9] if two integers, print them with a comma in between.

[10] if more than two integers, print the first and last with a dash in between.
