
sub f_simple {
    my($r, $c, @l) = @_;
    my @matrix = map [ (0) x $c ], 0 .. $r-1;
    for( @l ){
        my($ir, $ic) = @$_;
        $matrix[ $ir ][ $_  ]++ for 0 .. $c-1;
        $matrix[ $_  ][ $ic ]++ for 0 .. $r-1;
    }
    my $oddcount = 0;
    for( @matrix ){
        for ( @$_ ){
            $oddcount += $_ % 2
        }
    }
    $oddcount
}

sub f_faster_and_less_memory {
    my($r, $c, @l) = @_;
    my @oddr = (0) x $r; $oddr[ $$_[0] ] ^= 1 for @l;
    my @oddc = (0) x $c; $oddc[ $$_[1] ] ^= 1 for @l;
    0 + map { //; grep $' ^ $_, @oddc } @oddr
}

my @tests = map [ $$_{output}, @{ $$_{input} }{'row','col'}, @{$$_{input}{locations}} ],
    { input => { row => 2, col => 3, locations => [ [0,1],[1,1] ]             }, output => 6 },
    { input => { row => 2, col => 2, locations => [ [1,1],[0,0] ]             }, output => 0 },
    { input => { row => 3, col => 3, locations => [ [0,0],[1,2],[2,1] ]       }, output => 0 },
    { input => { row => 1, col => 5, locations => [ [0,2],[0,4] ]             }, output => 2 },
    { input => { row => 4, col => 2, locations => [ [1,0],[3,1],[2,0],[0,1] ] }, output => 8 };

print f_simple(                 @$_[1..$#$_] ) == $$_[0] ? "ok\n" : "error\n" for @tests;
print f_faster_and_less_memory( @$_[1..$#$_] ) == $$_[0] ? "ok\n" : "error\n" for @tests;
