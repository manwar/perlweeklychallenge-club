use v6;

#| Calculate the largest slace of Pie from Pythagoras Pie Puzzle
sub MAIN( Bool :v($verbose) = False ) {
    my $cake = FatRat.new(1);
    my $slice = 0;
    my $person = 0;
    for 1..100 -> $size { 
        my $nslice = $cake * ($size/100);
        $cake -= $nslice;
        if $nslice > $slice  {
            $slice = $nslice;
            $person = $size;
        }
        say "Person $size gets {$nslice*100}%" if $verbose;
    }
    say "Person $person gets {$slice*100}% of the cake or {$slice.nude().join("/")}";
}