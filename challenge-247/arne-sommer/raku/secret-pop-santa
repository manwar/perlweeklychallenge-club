#! /usr/bin/env raku

multi MAIN (Int $example where $example == 1|2, :v(:$verbose))
{
  my @names = $example == 1
  ?? ('Mr. Wall',
      'Mrs. Wall',
      'Mr. Anwar',
      'Mrs. Anwar',
      'Mr. Conway',
      'Mr. Cross',
     )
  !! ('Mr. Wall',
      'Mrs. Wall',
      'Mr. Anwar',
     );

  MAIN(@names, :$verbose);
}

multi MAIN (*@names, :v(:$verbose))
{
  my %count;

  @names.map({%count{family($_)}++});

  say ":Count: { %count.raku }" if $verbose;

  my @sorted = @names.sort({ %count{family($^b)} <=> %count{family($^a)} || Bool.pick });

  say ":Sorted: { @sorted.raku }" if $verbose;

  my $first = @sorted.shift;
  my $from  = $first;

  while (@sorted)
  {
    my $to = @sorted.shift;

    if (@sorted.elems && family($from) eq family($to))
    {
      my $next = @sorted.pop; # shift;
      @sorted.unshift: $to;
      $to = $next;
    }

    say "$from -> $to";

    $from = $to;
  }

  say "$from -> $first";
}

sub family ($name)
{
  my ($title, $family) = $name.words;
  return $family;
}
