use v5.30.0;

my $s = "Long Live Perl";
my @a = split "", $s;
my %hash;
for (0..$#a) {
    $hash{$a[$_]} = 0 if $hash{$a[$_]} == 1;
    $hash{$a[$_]} = 1 if !defined($hash{$a[$_]});
}
my $i = 0;
++$i until $hash{$a[$i]} == 1;
say $i;
