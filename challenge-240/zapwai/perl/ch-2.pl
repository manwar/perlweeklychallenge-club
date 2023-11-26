use v5.30;
my @int = (0, 2, 1, 5, 3, 4);
my @new;
$new[$_] = $int[$int[$_]] for (0 .. $#int);
say "Input: \@int = (" . join(", ", @int) . ")";
say "Output:\@new = (" . join(", ", @new) . ")";
