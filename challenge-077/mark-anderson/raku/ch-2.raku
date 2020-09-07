lonely-X([ <O O X>,
           <X O O>,
           <X O O> ]); 

lonely-X([ <O O X O>,
           <X O O O>,
           <X O O X>,
           <O X O O> ]);

sub lonely-X(@matrix) {
    my @results = gather {
        for ^@matrix -> $r {
            for ^@matrix[0] -> $c {
                if @matrix[$r][$c] eq "X" {
                    take [$r, $c] unless any((@matrix[$r-1][$c-1] // q{}), 
                                             (@matrix[$r-1][$c  ] // q{}), 
                                             (@matrix[$r-1][$c+1] // q{}),
                                             (@matrix[$r  ][$c-1] // q{}), 
                                             (@matrix[$r  ][$c+1] // q{}), 
                                             (@matrix[$r+1][$c+1] // q{}),
                                             (@matrix[$r+1][$c  ] // q{}),
                                             (@matrix[$r+1][$c-1] // q{})) eq "X";
                }
            }
        }
    }

    if @results.elems == 0 {
        say 0;
    }

    else {
        say "{@results.elems} as...";

        for @results -> [$r, $c] {
            say "Lonely-X found at Row {$r+1} and Col {$c+1}";
        }
    }
}
