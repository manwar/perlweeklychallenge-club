#!/usr/bin/env perl6

#| Prints a multiplication table with only the top half of the triangle
sub MAIN (
  Int $max where * > 0 = 11, #= The max number of the multiplication table (defaults to 11)
  --> Nil
) {
  my @range   = 1 .. $max;
  my $spacing = @range[*-1]².chars + 1;

  print ' x|';
  print sprintf('%' ~ $spacing ~ 's', $_) for @range;
  print "\n";
  print '--+';
  say [x] «
    -
    $spacing
    @range.elems()
  »;

  for @range -> $a {
    print sprintf('%2s|', $a);
    for @range -> $b {
      print sprintf('%' ~ $spacing ~ 's', $a ≤ $b ?? $a * $b !! '');
    }
    print "\n";
  }
}
