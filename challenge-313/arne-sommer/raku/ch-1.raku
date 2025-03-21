#! /usr/bin/env raku

unit sub MAIN (:i(:$in)  where $in.chars > 0,
               :o(:$out) where $out.chars > 0,
	       :v(:$verbose));

sub grouped ($str)
{
  my @parts = gather
  {
    my $curr;
    my $count = 0;
    
    for $str.comb -> $char
    {
      if $count && $curr ne $char
      {
        take $curr x $count;
	$count = 0;
      }
      $curr = $char;
      $count++;
    }
    take $curr x $count;
  } 

  say ": Grouped '$str' as { @parts.raku }" if $verbose;
  return @parts;
}

my @in  = grouped($in);
my @out = grouped($out);

my @combined = roundrobin(@in, @out);

say ": Zipped: {@combined.raku }" if $verbose;

my $status = True;

for @combined -> @pair
{
  if @pair.elems == 1
  {
    $status = False;
    say ": Trailing character: { @pair.flat }" if $verbose;
    last;
  }

  if @pair[0].substr(0,1) ne @pair[1].substr(0,1)
  {
    $status = False;
    say ": Different starting characters: { @pair[0].substr(0,1) } <> { @pair[1].substr(0,1) }" if $verbose;
    last;
  }

  if @pair[0].chars > @pair[1].chars
  {
    $status = False;
    say ": Not enough '{ @pair[0].substr(0,1) }' characters. Got { @pair[1].chars } requires { @pair[0].chars } " if $verbose;  
    last;
  }

  say ": Ok ('{ @pair[0] }' vs '{ @pair[1] }')" if $verbose;

}

say $status;