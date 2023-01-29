use v5.30.0;
no warnings "experimental";
my @array = (0,1,3);
my @list;
say "Input: (" . join(",",@array).")";
print "Output: ";
for (0..scalar @array) {
    push @list, $_ unless ($_ ~~ @array);
}
say join(",", @list);
