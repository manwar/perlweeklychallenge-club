use v5.38;
##
# You are given an array of positive integers.
# Write a script to separate the given array into single digits.
##
sub separate_digits{
    return separater([], @_); 
}

sub separater{
    my $seperated = shift;
    return @{$seperated} if @_ == 0;
    my @digits = @_;
    push @{$seperated}, split //, shift @digits;
    separater($seperated, @digits);
}

MAIN:{
    say join q/,/, separate_digits 1, 34, 5, 6;
}