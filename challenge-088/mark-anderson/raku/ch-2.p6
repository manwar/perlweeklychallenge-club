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

sub spiral(@step1) {
    my @step2 = ([Z] @step1).reverse;
    my @step3 = ([Z] @step2).reverse;
    my @step4 = ([Z] @step3).reverse;
    my @trips =  [Z] @step1, @step2, @step3, @step4;
    my $elems = @step1.elems * @step1[0].elems;
    my @result;

    for @trips.kv -> $k, @t {
        for @t -> @step {
            @result.push: @step[$k..*-$k-2];
        }
    }

    @result = (@result>>.Array).flat[^$elems];

    # handle the case when matrix is 3 X 3, 5 X 5, 7 X 7 
    # etc. where I can't seem to get the center element :(
    unless @result[*-1] {
        my $i = @step1 / 2;
        @result[*-1] = @step1[$i][$i];
    }

    @result;
}
