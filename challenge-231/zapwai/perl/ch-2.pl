use v5.30;
my @list = ("7868190130M7522","5303914400F9211","9273338290F4010");
#@list = ("1313579440F2036","2921522980M5644");
my $cnt = 0;
my @age;
foreach my $item (@list) {
    my @stuff = split "", $item;
    my $age = join "", ($stuff[11], $stuff[12]);
    push @age, $age;
    $cnt++ if ($age >= 60);
}
say "Input: \@list = (" . join(", ",@list) . ")";
print "Output: $cnt \t";
say "(Ages are: " . join(", ",@age) . ")";
