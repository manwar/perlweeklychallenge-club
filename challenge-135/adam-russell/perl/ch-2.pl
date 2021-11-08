use strict;
use warnings;
##
# You are given 7-characters alphanumeric SEDOL.
# Write a script to validate the given SEDOL. 
# Print 1 if it is a valid SEDOL otherwise 0.
##
use boolean;

sub is_sedol{
    my($sedol) = @_;
    my $base = substr($sedol, 0, 6);
    my $check_digit = substr($sedol, 6, 1); 
    ##
    # check length
    ##
    return false if length($sedol) != 7;
    ##
    # check for alphanumerics only
    ##
    my $test_base = $base;
    $test_base =~ tr/[0-9][B-Z]//d;
    return false if $test_base;
    ##
    # confirm the check_digit
    ##
    return false if $check_digit != compute_check_digit($base);
    ##
    # all tests passed!
    ##
    return true;
}

sub compute_check_digit{
    my($base) = @_;
    my @chars = split(//, $base);
    my @weights = (1, 3, 1, 7, 3, 9),
    my $sum = 0;
    do{
        my $c = ord(shift @chars);
        if($c >= 66 && $c <= 90){
            $sum += (($c - 64 + 9) * shift @weights);
        }
        if($c >= 48 && $c <= 57){
            $sum += (($c - 48) * shift @weights);
        }
    }while(@chars);
    return (10 - ($sum % 10)) % 10
}

MAIN:{
    print is_sedol(2936921) . "\n";
    print is_sedol(1234567) . "\n";
    print is_sedol("B0YBKL9") . "\n";
}