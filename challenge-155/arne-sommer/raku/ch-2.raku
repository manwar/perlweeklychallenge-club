#! /usr/bin/env raku

unit sub MAIN (Int :$n where $n != 0 = 3, :i(:$iterations) = 1000, :v(:$verbose));

my $fibonacci     := (0, 1, * + * ... *);
my $pisano-period := $fibonacci.map( * % $n);

for 1 .. Inf -> $size
{
  next unless $pisano-period[$size + 1] == 0;

  my $start = 0;

  my @first = $pisano-period[$start .. $size];

  say ": [$start] - { @first.join(", ") }" if $verbose;

  loop
  {
    my @next = $pisano-period[$start + $size + 1 .. $start + $size + $size +1];
    say ": [$start] - { @next.join(", ") }" if $verbose;
    last unless @first cmp @next eq "Same";
    $start = $start + $size +1;

    if $start > $size * $iterations
    {
      say $size + 1;
      exit;
    }
  }
}