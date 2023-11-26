use v5.30;
my @str = ("Perl", "Python", "Pascal");
my ($acr, $chk) = ("", "ppp");
foreach my $word (@str) {
    my @t = split "", $word;
    $acr .= shift @t;
}
say "Input:  \@str = @str \n\t\$chk = $chk";
say "Output: ", ($chk eq lc $acr) ? "True" : "False";
