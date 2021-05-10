#!raku

sub MAIN( Int $top where { $top > 1 } ) {
    # my @haystack = (1 xx $top, 2 xx $top / 2).flat;
    # my @solutions;

    # # get all possible combinations
    # for @haystack.permutations {
    #     # check every sub-array that gives me the sum
    #     for 0 ..^ $_.elems -> $index {
    #         @solutions.push: $_[ 0 .. $index ]  if $_[ 0 .. $index ].sum == $top;
    #     }
    # }



    # my @solutions;
    # my @haystack = 1,2;

    # my @current-solution;
    # while ( @current-solution.sum < $top ) {
    #     if  @current-solution.sum + @haystack[ 1 ] <= $top {
    #         @current-solution.push: @haystack [ 1 ];
    #     }
    #     elsif @current-solution.sum + @haystack[ 0 ] <= $top {
    #         @current-solution.push: @haystack [ 0 ];
    #     }
    # }


    my @solutions;
    @solutions.push: 1 xx $top;
    @solutions.push: 2 xx $top / 2 if $top %% 2;

    my @current-solution;
    while ( @current-solution.sum != $top ) {
        @current-solution.push: 2 if @current-solution.sum + 2 <= $top;
        @current-solution.push: 1 if @current-solution.sum + 1 <= $top;
    }

    if @current-solution.sum == $top {
        @solutions.push: $_ for @current-solution.permutations
    }
    

    
    # print only unique values
    for @solutions.unique( as => { .Str } ) -> @current-solution {
        say "";
        "%d step%s ".sprintf( $_, $_ > 1 ?? 's' !! '' ).print for @current-solution;
        say "";
    }
    
    
}

