use v6;

subset Roman-str of Str where $_ ~~ /^<[IVXLCDMivxlcdm]>+$/;

my %rom-tab = < I 1   V 5   X 10   L 50   C 100  D 500  M 1000
               IV 4  IX 9   XL 40  XC 90  CD 400   CM 900 >;
my @ordered_romans = reverse sort { %rom-tab{$_} }, keys %rom-tab;

sub from-roman (Roman-str $roman) {
    my $numeric = 0;
    my $prev_letter = "M";
    for $roman.uc.comb -> $letter {
        $numeric -= 2 * %rom-tab{$prev_letter}
            if %rom-tab{$letter} > %rom-tab{$prev_letter};
        $numeric += %rom-tab{$letter};
        $prev_letter = $letter;
    }
    return $numeric;
}

sub to-roman (Int $arabic is copy where  { 0 < $_ < 4000 }) {
    my $roman = "";
    for @ordered_romans -> $key {
        my $num = ($arabic / %rom-tab{$key}).Int;
        $roman ~= $key x $num;
        $arabic -= %rom-tab{$key} * $num;
    }
    return $roman;
}

say "$_\t=>\t", from-roman $_ for <MM MCM LXXIII XCIII IC XCIX xv>;

my @test_nums =  <19 42 67 90 97 99 429 498 687 938 949 996 2145 3597>;
say "From Arabic to Roman";
say "$_\t=>\t", to-roman $_.Int for @test_nums;

say "Some round trips: from Arabic to Roman to Arabic";
say "$_\t=>\t", from-roman to-roman $_.Int for @test_nums;

say "Sanity check (round trip through the whole range)";
for (1..3999) {
        my $result = from-roman to-roman $_;
            say "Error on $_ " unless $result == $_;
}
