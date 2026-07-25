sub f1 {
    my $num = shift;
    $k = '.' x shift;
    my $count = 0;
    $num =~ m{ $k (??{ $count += $& == 0 || $num % $& ? 0 : 1; '^' }) }x;
    $count;
}

sub f2 { 0 + grep { not $_[0] % ( 0 + substr($_[0], $_, $_[1]) || 9e999 ) }  0 .. length($_[0]) - $_[1] }

my @tests = (
    [ 240,  2 => 2],
    [ 1020, 2 => 3],
    [ 444,  2 => 0],
    [ 17,   2 => 1],
    [ 123,  1 => 2],
    [ 123000, 3 => 2],
    [ 21232123212300, 2 => 7]
);
    
print f1(@$_[0,1]) == $$_[2] ? "ok\n" : "ERROR\n" for @tests;
print f2(@$_[0,1]) == $$_[2] ? "ok\n" : "ERROR\n" for @tests;
