unit sub MAIN( Int $N );

my Int $t = 2;
my Int $r = 0;
my Int $n = $N;

while $n {
    my $a = $t +> 1;
    my $s = $N +& ( $t - 1);
    my $d = ( $N div $t );

    $r += $d * $a;
    $r += $s - $a + 1 if $s > $a - 1;
    $t = $t +< 1;
    $n = $n +> 1;
}

say $r % 1000000007;