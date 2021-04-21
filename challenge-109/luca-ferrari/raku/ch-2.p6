#!raku


sub MAIN() {
    my @nums    = <1 2 3 4 5 6 7>;
    my @letters = <a b c d e f g>;


    my @solutions;

    for @nums.permutations -> @current {
        my %squares;
        %squares{ @letters[ $_ ] } = @current[ $_ ] for 0 ..^ @letters.elems;


        my @sums;

        @sums.push: [+] %squares<a b>;
        @sums.push: [+] %squares<b c d>;
        @sums.push: [+] %squares<d e f>;
        @sums.push: [+] %squares<f g>;

        @solutions.push: %squares if @sums[ 0 ] == all @sums;
    }



    say $_ for @solutions;

}
