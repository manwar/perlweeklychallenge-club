use Test;
plan 4;

my @matrix = [ 1, 2, 3 ],
             [ 4, 5, 6 ],
             [ 7, 8, 9 ];

cmp-ok spiral(@matrix), &[eqv], [1, 2, 3, 6, 9, 8, 7, 4, 5], "Example 1";

@matrix = [  1 ..  4 ],
          [  5 ..  8 ],
          [  9 .. 12 ],
          [ 13 .. 16 ];

cmp-ok spiral(@matrix), &[eqv], 
       [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10], "Example 2";

@matrix = [ 1, 2 ],
          [ 3, 4 ],
          [ 5, 6 ],
          [ 7, 8 ];

cmp-ok spiral(@matrix), &[eqv], [1, 2, 4, 6, 8, 7, 5, 3], "Rows > Cols";

@matrix = [ 1, 2, 3, 4 ],
          [ 5, 6, 7, 8 ];

cmp-ok spiral(@matrix), &[eqv], [1, 2, 3, 4, 8, 7, 6, 5], "Cols > Rows";

#
# Abandoning my atrocious solution and going with the algorithm  
# implemented by James Smith, Feng Chang, (and possibly others).
#
sub spiral(@matrix) {
    my @r;

    while @matrix {
        @r.append: |@matrix.shift; 

        try { @r.push: .pop } for @matrix;

        try @r.append: $_ given @matrix.pop.reverse; 

        try -> $i { @r.push: .[$i].shift } for .end...0 given @matrix; 
    }

    @r;
} 
