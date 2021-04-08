#!env perl6

# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-107/>
# Task 1: Descriptive Numbers
# Write a script to generate Self-descriptive Numbers in a given base.

# In mathematics, a self-descriptive number
# is an integer m that in a given base b is b digits long
# in which each digit d at position n (the most significant digit being at position 0 and the least significant at position b - 1) counts how many instances of digit n are in m.

# For example, if the given base is 10, then script should print 6210001000.
#
# Invocation example:

# % perl6 weekly-challenge/pwc_43_2.p6 --base=10
# Starting generation for base 10
# Batch between 6210001000 and 6219991000
# Batch between 7210001000 and 7219991000
# Batch between 8210001000 and 8219991000
# Batch between 9210001000 and 9219991000

# What did we generate?

# [6210001000]

# Bye bye!



my $m = 6210001000;


sub MAIN( :$base? where { (10,4,5,7,8,9,11,12,16,36).grep: $base } = 10 ){
    say "Starting generation for base $base";

    # I need to do something for other bases!
    die "Not implemented!" if $base > 10;

    if ( $base <= 5 ) {
        my $end = ( $base - 1 ).Str x $base;
        my @nums = grep { validate $_.Int, $base }, 0 .. $end.Int;
        "\nWhat did we generate?\n".say;
        for @nums {
            .say
        }
    }
    else {
        # if the base is greater than 5 do a parallel scan

        my @tasks;
        for ( $base - 4 ) .. ( $base - 1 ) {
            @tasks.push:  Promise.start( {
                 # see <https://medium.com/@divyangrpatel/self-descriptive-number-best-algorithm-95b281e6de05>
                 my $start = '%d21%s1000'.sprintf: $_, '0' x ( $base - 4 - 3 ).Int;
                 my $end   = '%d21%s1000'.sprintf: $_, ( $base - 1 ) x ( $base - 4 - 3 ).Int;
                 say "\tBatch between $start and $end";

                my @nums = grep { validate $_.Int, $base }, $start .. $end;
             } );
        }

        await @tasks;
        "\nWhat did we generate?\n".say;
        for @tasks {
            .result.say if .result;
        }

    }

    say "\nBye bye!";
}


# Splits the number into an array of single digits, so that the first element is
# the most important digit of the number.
# Then greps the digit in the whole array and counts how many times it appears.
# If the digit appears the right number of times, the number is fine.
sub validate( Int $number, Int $base ){
    my @digits = $number.Str.split( '', :skip-empty );

    # the number must have the same length
    return False if @digits.elems != $base;

    # the number must have at least one zero!
    return False if ! @digits.grep: 0;

    my $ok = True;
    for @digits {
        my $digit    = $_;
        my $position = $++;
        $ok &&= @digits.grep( * == $position ).elems == $digit;
        return False if ! $ok;
    }

    return True;
}
