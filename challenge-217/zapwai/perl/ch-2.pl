use v5.30.0;
my @list = (1, 23);
#my @list = (5, 11, 4, 1, 2);
say "Input: \@list = (" . join(",",@list) . ")";
print "Output: ";
@list = reverse sort @list;
say @list;
