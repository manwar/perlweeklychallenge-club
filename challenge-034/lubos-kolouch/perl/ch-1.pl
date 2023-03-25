# Define an array of numbers
my @numbers = ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 );

# Print the first three elements of the array using a slice
print "First three elements: ", join( ", ", @numbers[ 0 .. 2 ] ), "\n";

# Print the last five elements of the array using a slice
print "Last five elements: ", join( ", ", @numbers[ -5 .. -1 ] ), "\n";

# Define an array of names
my @names = ( "Alice", "Bob", "Charlie", "Dave", "Emily" );

# Define a hash of ages
my %ages = (
    "Alice"   => 27,
    "Charlie" => 32,
    "Emily"   => 24
);

# Use a hash slice to print the ages of Alice, Charlie, and Emily
print "Ages: ", join( ", ", @ages{ @names[ 0, 2, 4 ] } ), "\n";
