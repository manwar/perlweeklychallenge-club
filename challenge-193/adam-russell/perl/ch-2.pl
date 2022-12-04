use v5.36;
##
# You are given a list of strings of same length, @s.
# Write a script to find the odd string in the given list. 
# Use positional alphabet values starting with 0, i.e. a = 0, b = 1, ... z = 25.
##
sub odd_string{
    my(@strings) = @_;
    my %differences;
    for my $string (@strings){
        my $current;
        my $previous;
        my @differences;
        map {
            unless($previous){
                $previous = $_;
            }
            else{
                $current = $_;
                push @differences, ord($current) - ord($previous);
                $previous = $current;
            }        
        } split(//, $string);
        my $key = join(",", @differences);
        my $size_before = keys %differences;
        $differences{$key} = undef;
        my $size_after = keys %differences;
        return $string if $size_before > 0 && $size_after - $size_before == 1;
    }
    return undef;
}

MAIN:{
    say odd_string(qw/adc wzy abc/);
    say odd_string(qw/aaa bob ccc ddd/);
    say odd_string(qw/aaaa bbbb cccc dddd/) || "no odd string found";
    say odd_string(qw/aaaa bbob cccc dddd/);
}