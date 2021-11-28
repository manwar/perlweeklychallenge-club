#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @pairs = (
    # Given cases
    [
        11,
         1
    ],
    [
        101,
          1
    ],
    [
        100,
         11
    ],

    # Additional test cases
    [
        1001011011,
        1011001011
    ]
);
my $pair;

foreach $pair (@pairs){
    my ($a, $b) = map(binaryNumber->new($_), @{$pair});

    # This formatting will accommodate numbers
    # up to 16 bits
    printf(
        "   %+16s\n + %+16s\n ------------------\n   %+16s\n\n",
        $a,
        $b,
        $a + $b
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Begin package binaryNumber
# A minimal class set up to meet the requirement for operator overloading when
# adding decimal-coded binary numbers; for brevity, only those methods required
# for that purpose have been implemented.
################################################################################
package binaryNumber;

# Overload operators for getting string
# representations and adding
use overload (
    '""' => "getValue",
    '+'  => "add"
);



################################################################################
# Create a new binaryNumber object
# Takes one argument:
# * The decimal-coded binary number to store, which must consist solely of 1's
#   and 0's- this is best thought of as a string rather than a numerical
#   argument
# Returns on success:
# * A ref to a binaryNumber object
# Returns on error:
# * undef if the argument is not valid
################################################################################
sub new{
    my $class = shift();
    my $value = shift();

    # Make sure the value is just a string of
    # ones and zeros
    return(undef)
        unless($value =~ m/^[01]+$/);

    return(
        bless(
            {
                # Force the value to be the numerical
                # representation
                value => $value + 0
            },
            $class
        )
    );

}



################################################################################
# Get the value stored in a binaryNumber object
# Takes no arguments
# Returns:
# * The decimal-coded binary number stored in the binaryNumber object, which
#   should be interpreted as a string of ones and zeros; further processing is
#   required to convert this to a proper numerical value if needed
################################################################################
sub getValue{
    my $self = shift();

    return($self->{value});

}



################################################################################
# Add two binaryNumber objects arithmetically
# Takes one argument:
# * A ref to the binaryNumber object whose value is to be added to the one from
#   the object from which this method is invoked; the latter object's value
#   will NOT be altered
# Returns on success:
# * A ref to a binaryNumber object containing the sum of the original two
#   objects' values
# Returns on error:
# * undef if its argument is not a ref to a binaryNumber object
# Example:
# $c = $a->add($b);  # Where $a and $b are refs to binaryNumber objects and $c
#                    # will be populated with one that contains the sum
################################################################################
sub add{
    use Scalar::Util qw(blessed);

    my $self = shift();
    my $addend = shift();

    # Make sure we're actually adding a
    # binaryNumber object
    return(undef)
        unless(blessed($addend) && $addend->isa('binaryNumber'));

    # Store the digits individually- but
    # reversed (least-significant bit first)
    my @self_digits = reverse(split("", $self->{value}));
    my @addend_digits = reverse(split("", $addend->getValue()));
    my $max;
    my $i;
    my $carry = 0;
    my @sum_digits;

    # Get the length of the longer list of
    # digits
    $max =
        scalar(@self_digits) > scalar(@addend_digits)
        ?
        scalar(@self_digits)
        :
        scalar(@addend_digits);

    # Loop over the longest list, adding
    # as we go
    for($i = 0; $i < $max; $i++){
        my $self_digit = $self_digits[$i];
        my $addend_digit = $addend_digits[$i];

        # Bitwise-ANDing by 0x01 forces the
        # digits to take on their numerical
        # representation for Boolean algebra;
        # use 0 if we've run out of digits in
        # the shorter of the lists
        $self_digit = defined($self_digit) ? $self_digit & 0x01 : 0;
        $addend_digit = defined($addend_digit) ? $addend_digit & 0x01 : 0;

        # Store the results of addition
        push(
            @sum_digits,
            $self_digit ^ $addend_digit ^ $carry
        );

        # Set the carry bit if two or more out of
        # the three potential addend bits
        # (including the carry bit itself) are
        # true
        $carry = $carry ^ $self_digit ? $addend_digit : $carry;
    }

    # Add a leading 1 if there's a carry bit
    # left over
    push(@sum_digits, 1) if($carry);

    # Reverse (or un-reverse...) the sum
    # digits and generate a new binaryNumber
    return(
        binaryNumber->new(join("", reverse(@sum_digits)))
    );

}



1;
################################################################################
# End package binaryNumber
################################################################################



