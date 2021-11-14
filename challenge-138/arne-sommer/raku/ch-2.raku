#! /usr/bin/env raku

unit sub MAIN (Int $psq where $psq.sqrt.Int == $psq.sqrt && $psq > 9, :v(:$verbose));

my $sqrt = $psq.sqrt;
my $size = $psq.chars;

say ": Square root of $psq = $sqrt" if $verbose;

my $found = False;

my $splits := gather
{
  recurse( $psq, () );
}

for $splits -> $candidate
{
  my @list = @$candidate;

  if @list.elems == 1
  {
     say ": Candidate list: { @list.join(", ") } (ignored size)" if $verbose;
     next;
  }

  my $sum = @list.sum;

  if $sqrt == $sum
  {
    say ": Candidate list: { @list.join(", ") } - with correct sum $sqrt" if $verbose;
    say 1 unless $found;
    
    $verbose
      ?? ( $found = True )
      !! exit;
  }
  else
  {
    say ": Candidate list: { @list.join(", ") } (wrong sum $sum vs expected $sqrt)" if $verbose;
  }
}

say 0 unless $found;

sub recurse ($remainder, @done)
{
  for 1 .. $remainder.chars -> $count
  {
    my $partial = $remainder.substr(0, $count);
    my $new     = $remainder.substr($count);
    my @so-far  = @done.clone;
    
    @so-far.push: $partial;

    $new eq ""
      ?? take @so-far
      !! recurse($new, @so-far);
  }
}
