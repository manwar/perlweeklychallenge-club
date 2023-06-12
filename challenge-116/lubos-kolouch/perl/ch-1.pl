sub split_number {
    my ($n) = @_;
    
    my @result;    
    if($n >= 10){
        my @digits = split //, $n; 
        my $first = shift @digits;
        push @result, $first;
        foreach my $digit (@digits){
            if($digit - $first == 1){
                push @result, $digit;
                $first = $digit;
            } else {
                @result = ($n);
                last;
            }   
        }
    }
    return join(',', @result);
}

use Test::More tests => 3;

is(split_number(1234), "1,2,3,4", "Test 1");  
is(split_number(91011), "9,10,11", "Test 2");
is(split_number(10203), "10203", "Test 3");

