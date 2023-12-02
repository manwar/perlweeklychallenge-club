use Test;

sub sort-language(@langs, @popularity) {
    my @paired = @langs Z @popularity;
    my @sorted = @paired.sort({$^a[1] <=> $^b[1]});
    return @sorted.map(*[0]);
}

# Test Cases
is-deeply sort-language(<perl c python>, <2 1 3>), <c perl python>, 'Example 1';
is-deeply sort-language(<c++ haskell java>, <1 3 2>), <c++ java haskell>, 'Example 2';

done-testing;
