use v6;

sub MAIN(:$file?, *@letters where *.all.chars == 1) {
    say @letters;
    my $file-handle = .IO with $file;
    $file-handle ||= $*IN;
    my $tiles = Bag.new(@letters>>.fc);
    for $file-handle.lines>>.fc -> $word {
        $word.comb.Bag (<=) $tiles
            and say $word;
    }

}
