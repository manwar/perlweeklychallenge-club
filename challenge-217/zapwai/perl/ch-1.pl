use v5.30.0;
my @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3]);

print "Input: \@matrix = (";
for (0 .. $#matrix) {
    print '[' . join(",",@{$matrix[$_]}) . "]";
    print ", " unless ($_ == $#matrix);
}
say ")";
print "Output: ";
my @list;
push @list, @$_ foreach (@matrix);
@list = sort @list;
say $list[2];
say "Sorted list: " . join(",", @list);
