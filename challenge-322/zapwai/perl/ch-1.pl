use feature qw( say signatures );
sub proc($str, $i) {
    say "Input: \$str = $str, \$i = $i";
    my @letters = grep { /\w/ } split '', $str;
    my $rem = @letters % $i;
    my $q = int( @letters / $i );
    my $output;
    for (1 .. $rem) {
        $output .= $letters[$_-1] ;
    }
    for my $j (0 .. $q - 1) {
        $output .= '-' unless ($rem == 0 && $j == 0);
        for my $k (0 .. $i - 1) {
            $output .= $letters[$i*$j + $k + $rem];
        }
    }
    say "Output: $output";
}
my $str = "ABC-D-E-F"; my $i = 3;
proc($str, $i);
$str = "A-BC-D-E"; $i = 2;
proc($str, $i);
$str = "-A-B-CD-E"; $i = 4;
proc($str, $i);
