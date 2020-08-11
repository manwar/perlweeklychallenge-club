raku -e 'say (sub ($_) { .isa(Pair) ?? (.key => .value.reverse.map: { samewith $^a }) !! $_ })(1 => (2 => (4, 5), 3 => (6, 7)))'
