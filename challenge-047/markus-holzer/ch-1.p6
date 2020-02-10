# Implements only the simple additive kind

subset Roman of Str where * ~~ / ^ M* D* C * L* X* V* I* $ /;

my @r = :M(1000), :D(500), :C(100), :L(50), :X(10), :V(5), :I(1);
my %r = @r.Hash;

sub r2d( $r is copy ) { 
    $r .= uc;
    %r{$r} || reduce { $^a >= $^b ?? $a + $b !! $a - $b }, $r.comb.map( -> $d { %r{$d} } );
}

sub d2r( $d is copy ) {
    join '', gather while $d > 0 {
         my ($k, $n) = @r.first( *.value <= $d ).kv; 
         take $k;
         $d -= $n;
    }
}

multi sub MAIN(Roman $n, '+', Roman $m) { say d2r( $n.&r2d + $m.&r2d ) }
multi sub MAIN(Roman $n, '-', Roman $m) { say d2r( $n.&r2d - $m.&r2d ) }
multi sub MAIN(Roman $n, "×", Roman $m) { say d2r( $n.&r2d × $m.&r2d ) }
multi sub MAIN(Roman $n, '÷', Roman $m) { say d2r( ($n.&r2d ÷ $m.&r2d).Int ) }

# ~\perlweeklychallenge-club\challenge-047\markus-holzer>6 ch-1.p6 L ÷ II
# XXV
#~\perlweeklychallenge-club\challenge-047\markus-holzer>