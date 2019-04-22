perl6 -e 'my $letters = join "", sort qw/a e i t r s o u a /; for "words.txt".IO.lines -> $line { my $norm = $line.comb.sort.join(""); say $line if defined index($letters, $norm);}'
