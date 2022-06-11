my  $seen = SetHash.new;
my @pangram;
for 'dictionary.txt'.IO.lines -> $word {
    my @new_letters = grep {not $seen{$_}}, $word.comb;
    next if @new_letters == 0;
    $seen ∪= @new_letters;      # set union operator
    push @pangram, $word;
    last if $seen.elems == 26;
}
say @pangram;
