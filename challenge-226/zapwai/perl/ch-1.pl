use v5.30;
my $string = 'lacelengh';
my @indices = (3,2,0,5,4,8,6,7,1);
say "Input: \$string = $string, \@indices = (" . join(",",@indices) . ")";
my @S = split "", $string;
my @R;
for my $i (0 .. $#indices) {
    $R[$indices[$i]] = $S[$i];
}
my $ans = join "", @R;
say "Output: $ans";    
