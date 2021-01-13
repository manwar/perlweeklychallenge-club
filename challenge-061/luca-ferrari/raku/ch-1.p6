#!env raku
#
#
# Given a list of 4 or more numbers,
# write a script to find the contiguous sublist that has the maximum product.
# The length of the sublist is irrelevant; your job is to maximize the product.
# Example
#
# Input: [ 2, 5, -1, 3 ]
#
# Output: [ 2, 5 ] which gives maximum product 10.


sub MAIN() {
    my @input = 2, 5, -1, 3;
    my @output;

    loop ( my $i = 0; $i < @input.elems; $i++ ){
        for $i ^..^ @input.elems {
             @output = @input[ $i .. $_ ] if ( ! @output || ( [*] @input[ $i .. $_ ] ) > ( [*] @output ) );
        }
    }

    say "Max product is { [*] @output }  made by { @output.join( ' x ' ) }";
}
