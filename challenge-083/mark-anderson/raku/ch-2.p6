unit sub MAIN(*@A where (.elems > 1 and .all ~~ UInt and .all > 0));

my $A = gather {
    for @A.keys.combinations.skip -> @C {
        my @N = @A;
        @N[@C].map(* *= -1);
        take [@N.sum, @C.elems, @N] if @N.sum >= 0; 
    }
} 

my ($Sum,   $A2) = (min classify { .[0] }, $A).kv;
my ($Flips, $A3) = (min classify { .[1] }, |$A2).kv; 

say "Sum   = $Sum\nFlips = $Flips\n";
say .[2].fmt("(%d)", " + ") for |$A3;
