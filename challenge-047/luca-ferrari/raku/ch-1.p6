#!env raku
#
# Perl Weekly Challenge 47
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/>
#
# Task 1
# Roman Calculator
# Write a script that accepts two roman numbers and operation.
# It should then perform the operation on the give
# roman numbers and print the result.
# For example,
# perl ch-1.pl V + VI
# It should print
# XI
#
#
# Example of output
# % raku ch-1.p6  V + IX
# XIV


my %roman-to-arabic = :I(1), :V(5), :X(10), :L(50), :C(100), :D(500), :M(1000);


# Function to convert a roman number into an arabic one.
sub convert-roman-to-arabic( Str:D $roman  ) {
    # convert to uppercase, reverse the string
    # and translates into numbers. For example,
    # IX => [ 10 1 ]
    # then map so that the current value is multiplied by -1 if the
    # previous one is higher
    my @arabic-digits = $roman.uc.comb.reverse.map: {
        state $last = 0;
        my $value = %roman-to-arabic{ $_ };
        $value *= -1 if $value < $last;
        $last = $value;
        $value;
    };

    return [+] @arabic-digits;
}


# Function to convert an arabic number into a roman one.
sub convert-arabic-to-roman( Int $arabic  ) {

    # special cases: what to subtract from every value
    my %subtractors = 1_000 => 100,
    500 => 100,
    100 => 10,
    50 =>  10,
    10 =>  1,
    5 =>  1,
    1 => 0;

    # reverse the map of the values so that each arabic value
    # corresponds to a letter
    my %translator = %roman-to-arabic.map( { $_.value => $_.key } );


    return '' if ! $arabic;

    for %subtractors.pairs.sort: { $^b.key.Int <=> $^a.key.Int } -> $pair {
        my $subtractor = $pair.key.Int;
        my $removing   = $pair.value.Int;

        return %translator{ $subtractor } ~ convert-arabic-to-roman( $arabic - $subtractor.Int ) if $arabic >= $subtractor;
        return %translator{ $removing } ~ convert-arabic-to-roman( $arabic + $removing.Int ) if $arabic >= $subtractor - $removing;

    }

}



########################################
# Main program
########################################

die "Usage: $*PROGRAM <operand> <operator> <operand>" if @*ARGS.elems != 3;

my $operand-a = convert-roman-to-arabic( @*ARGS[0] );
my $operand-b = convert-roman-to-arabic( @*ARGS[2] );

my $result = do given @*ARGS[1].trim {
    when '+' { $operand-a + $operand-b; }
    when '-' { $operand-a - $operand-b; }
    when '/' { $operand-a / $operand-b; }
    when '*' { $operand-a * $operand-b; }
};

say convert-arabic-to-roman( $result );
