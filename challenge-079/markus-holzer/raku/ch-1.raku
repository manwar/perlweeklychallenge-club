unit sub MAIN( Int $N );

my Int $t = 2;
my Int $r = 0;
my Int $n = $N;

while $n {
    my $a = $t +> 1;
    my $s = $N +& ( $t - 1 );
    my $d = ( $N div $t );

    $r  += $d * $a;
    $r  += 1 + $s - $a if $s > $a - 1;
    $t +<= 1;
    $n +>= 1;
}

say $r % 1000000007;