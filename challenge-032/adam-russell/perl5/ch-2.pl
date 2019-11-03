use strict;
use warnings;
##
# Write a function that takes a hashref where the keys 
# are labels and the values are integer or floating 
# point values. Generate a bar graph of the data and 
# display it to stdout.
##
use JSON::PP;
use constant MAX_LENGTH => 10; 

MAIN:{
    my $input = $ARGV[0];
    my $data = decode_json($input);
    my @sorted_keys = sort {$data->{$b} <=> $data->{$a}} keys %{$data};
    my @sorted_values = sort {$a <=> $b} values %{$data};
    my $min = $sorted_values[0];
    my $max = $sorted_values[@sorted_values - 1];
    for my $key (@sorted_keys){
        my $scaled = ($data->{$key} - $min + 1)/($max - $min);  
        print "$key\t| ";
        print "#" x int(MAX_LENGTH * $scaled) . "\n";
    }  
}
