use v5.30;
my @str = ("abc", "bce", "cae");
#my @str = ("yxz", "cba", "mon");
my @unsorted;
for my $str (@str) {
    my @l = split "", $str;
    my $for = join("", sort @l);
    my $bak = join("", reverse sort @l);
    push @unsorted, $str unless ( ($for eq $str) or ($bak eq $str) );
}
say "Input: \@str = @str";
say "Output: " . ($#unsorted + 1);
say "Unsorted items: @unsorted";
