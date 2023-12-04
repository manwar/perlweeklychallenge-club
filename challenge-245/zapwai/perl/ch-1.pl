use v5.30;
my @lang = ('perl', 'c', 'python');
my @pop = (2, 1, 3);
my @ans;
foreach my $i (0 .. $#pop) {
    $ans[$pop[$i] - 1] = $lang[$i];
}
say "Input : \@lang = @lang\n \t\@pop = @pop";
say "Output: @ans";
