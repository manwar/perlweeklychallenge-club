#! /usr/bin/env raku

unit sub MAIN (Int $int where 1 <= $int <= 100,
              :v(:$verbose));

my $fib := (1, 1, * + * ... Inf);

my @rev;

for $fib -> $f
{
  last if $f > $int;
  @rev.unshift: $f;
}

sink @rev.pop;

say ": Reverse fib: { @rev.join(", ") }" if $verbose;

recurse( (), @rev );

sub recurse(@zeckendorf is copy, @rev is copy)
{
  say ": Z:{ @zeckendorf.join(",") } R: { @rev.join(",") }" if $verbose;

  if @zeckendorf.sum == $int
  {
    say @zeckendorf.join(",");
    exit;
  }

  return if @zeckendorf.sum > $int;
  return unless @rev.elems;

  my $next = @rev.shift;

  recurse(@zeckendorf, @rev);

  @zeckendorf.push: $next;
  sink @rev.shift if @rev.elems;

  recurse(@zeckendorf, @rev)
}  
