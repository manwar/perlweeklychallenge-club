use strict;
use warnings;
##
# You are given 2 strings, $A and $B.
# Write a script to find out common base strings in $A and $B.
## 
use boolean;

sub contains{
    my($s0) = @_;
    return sub{
        my($s) = @_;
        return [true, $s0] if($s =~ m/^($s0)+$/g);
        return [false, $s0];
    }
}

sub make_checks{
    my($s) = @_;
    my @letters = split(//, $s);
    my @checks;
    for my $i (0 .. @letters - 1){
        push @checks, contains(join("", @letters[0 .. $i]));
    }
    return @checks;
}

MAIN:{
    my($A, $B);
    $A = "abcdabcd";
    $B = "abcdabcdabcdabcd";
    my @checks;
    @checks = make_checks($A);
    print "$A, $B --> (";
    for my $check (@checks){
        if($check->($A)->[0] && $check->($B)->[0]){
            print $check->($A)->[1] . " ";
        }
    }
    print "\b)\n";
    $A = "aaa";
    $B = "aa";
    @checks = make_checks($A);
    print "$A, $B --> (";
    for my $check (@checks){
        if($check->($A)->[0] && $check->($B)->[0]){
            print $check->($A)->[1] . " ";
        }
    }
    print "\b)\n";
}