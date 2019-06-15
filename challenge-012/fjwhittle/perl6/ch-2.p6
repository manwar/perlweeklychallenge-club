# Operate on paths provided from $*IN, split into components.
# Output is then joined by the system directory separator.

$*IN.lines.map({ [.chomp.split($*SPEC.dir-sep)] }).reduce({
  # Find the minimum number of components
  my $n = min($^a.elems, $^b.elems);

  # Reduce components while the array heads don't match
  $n-- while $n > 0 and $^a[^$n] !~~ $^b[^$n];

  # Reduced result is the maximum matching array head;
  $^a[^$n];
}).join($*SPEC.dir-sep).put;
