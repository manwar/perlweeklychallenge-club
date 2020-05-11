#!env raku

# Write a script that accepts a number and returns the Excel Column Name it represents and vice-versa.

# Excel columns start at A and increase lexicographically
# using the 26 letters of the English alphabet,
# A..Z. After Z, the columns pick up an extra “digit”,
# going from AA, AB, etc.,
# which could (in theory) continue to an arbitrary number of digits.
# In practice, Excel sheets are limited to 16,384 columns.
#
#
# Example
# Input Number: 28 Output: AB
# Input Column Name: AD Output: 30



sub MAIN( $what  ) {
    my @letters = 'A' .. 'Z';
    my @column-name;


    # numeric value to be converted into a letter
    if $what ~~ Int && $what > 0 && $what <= 16_384 {
        my $column = $what.Int;


        while ( $column > @letters.elems ) {
            @column-name.push: @letters[ $column / @letters.elems  - 1 ];
            $column = $column % @letters.elems;
        }

        @column-name.push: @letters[ $column - 1 ];
        say "Cell $what is { @column-name.join }";
    }
    elsif $what ~~ Str {
        my $column;
        my $multiplier = 0;
        # string, try to find the cell number
        for $what.comb.reverse -> $current_letter {
            $column += @letters.first( $current_letter, :k ) + 1 + ( @letters.elems - 1 ) * $multiplier++;
        }

        say "Cell $what is $column";
    }





}
