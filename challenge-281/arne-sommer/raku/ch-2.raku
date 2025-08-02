#! /usr/bin/env raku

subset BOARDPOS where * ~~ /^<[a..h]><[1..8]>$/;
subset MOVE of Int where -7 <= * <= 7;

unit sub MAIN (BOARDPOS $start, BOARDPOS $end, :v(:$verbose));

my %seen = ( $start => True );

my @queue = \{ steps => 0, pos => $start, path => ($start,) };

while @queue
{
  my %curr = @queue.shift;

  say ": Steps %curr<steps>: at pos %curr<pos> (path: %curr<path>)" if $verbose;

  if (%curr<pos> eq $end)
  {
    say ": Arrived at target after %curr<steps> steps (path: %curr<path>)" if $verbose;
    say %curr<steps>;
    last;
  }

  for ( (-2,-1), (-2,1), (2,-1), (2,1), (-1,-2), (-1,2), (1,-2), (1,2)) -> ($row-offset, $col-offset)
  {
    my $new-pos = new-pos-knight(%curr<pos>, c => $col-offset, r => $row-offset) // next;
    next if %seen{$new-pos}++;
    @queue.push: { pos => $new-pos, steps => %curr<steps> +1, path => ( %curr<path>, $new-pos).flat };
  }
}

sub new-pos-knight (BOARDPOS $pos, MOVE :r(:$row-offset), MOVE :c(:$col-offset))
{
  my ($col, $row) = $pos.comb;

  my $new-row = $row + $row-offset;
  return unless 1 <= $new-row <= 8;

  my $new-col = (ord($col) + $col-offset).chr;
  return unless $new-col eq any(<a b c d e f g h>);

  return $new-col ~ $new-row;
}