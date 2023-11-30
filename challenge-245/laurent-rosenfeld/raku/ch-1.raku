sub sort-lang (@lang, @pop) {
    return ~ @lang[map {$_ - 1}, @pop];
}

my @tests =
    { lang => <perl c python>, pop => (2, 1, 3)},
    { lang => <c++ haskell java>, pop  => (1, 3, 2)};

for @tests -> %test {
    printf "%-20s", "%test<lang> => ";
    say sort-lang %test<lang>, %test<pop>;
}
