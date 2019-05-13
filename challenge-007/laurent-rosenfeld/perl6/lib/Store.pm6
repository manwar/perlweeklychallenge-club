unit package Store;

sub store (%hash, $file) is export {
    # stores a hash or array as lines containing key et values
    # such as: key | val1 val2 val3
    my $out;
    for %hash.kv -> $key, $val {
        $out ~= "$key | $val \n";
    }
    spurt $file, $out;
}
sub retrieve (%hash, $file) is export {
    # populates a hash of arrays with stored data
    for $file.IO.lines -> $line {
        my ($key, $val) = split /\s?\|\s?/, $line;
        %hash{$key} = $val.words;
    }
}
