

my $dnaseq = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';
my $complement = $dnaseq.trans('TAGC' => 'ATCG');

my %histogram = ( "A" => 0, "T" => 0, "C" => 0, "G" => 0 );
$dnaseq.comb.map(-> $c { %histogram{$c}++ });

say "nucleiobase count";
for 'A', 'T', 'C', 'G' -> $c {
    say "  $c: " ~ %histogram{$c};
}

say "Complement: " ~ $complement;
