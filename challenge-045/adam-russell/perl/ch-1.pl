use strict;
use warnings;
##
# Write a script that accepts a message from the 
# command line and prints the equivalent square secret 
# coded message.
##
use constant SQUARE_SIZE => 8;
sub encode{
    my($message) = @_;
    $message =~ tr/ //d;
    my $encoded;
    my @buckets;
    my @characters = split(//, lc($message));
    for my $i (0 .. @characters){
       $buckets[$i % SQUARE_SIZE] = [] if !$buckets[$i % SQUARE_SIZE];
       push @{$buckets[$i % SQUARE_SIZE]}, $characters[$i] if $characters[$i];  
    } 
    for my $bucket (@buckets){
        $encoded .= join("", @{$bucket}) . " ";
    }  
    return $encoded; 
}

MAIN:{
    my $message = $ARGV[0];
    print encode($message) . "\n"; 
}
