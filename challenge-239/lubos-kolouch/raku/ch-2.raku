sub count-consistent-strings($allowed, @strings) {
    my $count = 0;
    
    # Create a hash to store allowed characters
    my %allowed-chars = $allowed.comb.map: { $_ => True };
    
    for @strings -> $str {
        # Check if all characters in the string are in the allowed characters hash
        if all($str.comb.map: { %allowed-chars{$_}:exists }) {
            $count++;
        }
    }
    
    return $count;
}

# Test the function
use Test;

plan 3;

is count-consistent-strings('ab', <ad bd aaab baa badab>), 2, 'Test Case 1';
is count-consistent-strings('abc', <a b c ab ac bc abc>), 7, 'Test Case 2';
is count-consistent-strings('cad', <cc acd b ba bac bad ac d>), 4, 'Test Case 3';

