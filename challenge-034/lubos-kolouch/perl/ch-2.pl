#!/usr/bin/perl

# Define a function to add two numbers
sub add {
    my ( $a, $b ) = @_;
    return $a + $b;
}

# Define a function to subtract two numbers
sub subtract {
    my ( $a, $b ) = @_;
    return $a - $b;
}

# Define a function to multiply two numbers
sub multiply {
    my ( $a, $b ) = @_;
    return $a * $b;
}

# Define a function to divide two numbers
sub divide {
    my ( $a, $b ) = @_;
    return $a / $b;
}

# Define a dispatch table that maps operation names to functions
my %operation_table = (
    "add"      => \&add,
    "subtract" => \&subtract,
    "multiply" => \&multiply,
    "divide"   => \&divide
);

# Define a function that takes an operation name and two numbers, and performs the operation
sub perform_operation {
    my ( $operation, $a, $b ) = @_;
    if ( exists $operation_table{$operation} ) {
        return $operation_table{$operation}->( $a, $b );
    }
    else {
        die "Unknown operation '$operation'";
    }
}

# Test the dispatch table by performing some operations
print perform_operation( "add",      2,  3 ), "\n";    # Output: 5
print perform_operation( "subtract", 5,  1 ), "\n";    # Output: 4
print perform_operation( "multiply", 4,  6 ), "\n";    # Output: 24
print perform_operation( "divide",   10, 2 ), "\n";    # Output: 5
