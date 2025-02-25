use v6.d;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»

unit module Matrix;

sub matrix-say( @m is copy ) is export {
    for @m -> $row is rw {
        $row = $row.join( ",");
    }
    print "\nInput @matrix = [ [";
    print @m.join: "],\n                  [";
    print "],\n                ]\n";
}



