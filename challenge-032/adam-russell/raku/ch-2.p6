use JSON::Fast;
##
# Write a function that takes a hashref where the keys
# are labels and the values are integer or floating
# point values. Generate a bar graph of the data and
# display it to stdout.
##
sub term:<MAX-LENGTH> { 10 }; 

sub MAIN($input) {
    my %data = from-json $input; 
    my @sorted = %data.sort(*.value);
    my $min = @sorted[0].value;
    my $max = @sorted[@sorted.end].value;
    for %data.sort(*.value).reverse -> $pair {
        print $pair.key ~ "\t| "; 
        say "#" x ($pair.value - $min + 1) / ($max  - $min) * MAX-LENGTH;
    }  
} 
