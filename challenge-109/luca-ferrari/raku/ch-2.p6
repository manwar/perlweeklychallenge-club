#!raku


sub MAIN(  *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems && @nums.elems == 7 } ) {
    my @letters = 'a' .. 'g';
    my @solutions;

    # permutate all numbers to find out the correct sum
    for @nums.permutations -> @current {
        # build an hash to help visualize the answer
        my %squares;
        %squares{ @letters[ $_ ] } = @current[ $_ ] for 0 ..^ @letters.elems;

        # compute the sums
        my @sums;
        @sums.push: [+] %squares{ 'a' .. 'b' };
        @sums.push: [+] %squares{ 'b' .. 'd' };
        @sums.push: [+] %squares{ 'd' .. 'f' };
        @sums.push: [+] %squares{ 'f' .. 'g' };


        # if the first sum is equal to all the others, push this solution
        @solutions.push: %squares if @sums[ 0 ] == all @sums[ 1 .. * ];
    }



    say $_ for @solutions;

}
