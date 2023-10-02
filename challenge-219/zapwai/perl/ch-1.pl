use v5.30.0;
my @list = (-2, -1, 0, 3, 4);
@list = (5, -4, -1, 3, 6);
say "Input: \@list = (" . join(",",@list) . ")";
my @new = map { $_**2 } @list;
@new = sort { $a <=> $b } @new;
say "Output: (" . join(",",@new) . ")";
