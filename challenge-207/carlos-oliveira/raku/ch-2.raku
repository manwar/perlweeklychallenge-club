use Test;

sub h-index (@citations where all($_) ~~ Int:D) {
  my $h-index = 0;
  my $some-invalid = @citations.sort.reverse.first: { $_ < ++$h-index };
  return $some-invalid ?? $h-index - 1 !! $h-index;
}

is h-index([10, 8, 5, 4, 3]), 4;
is h-index([25, 8, 5, 3, 3]), 3;
is h-index([7, 7, 7]), 3;
is h-index([2, 1]), 1;
is h-index([1]), 1;
is h-index([]), 0;
