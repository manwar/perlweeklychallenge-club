use strict;
use warnings;
##
# Write a script to generate all Eban Numbers <= 100.
##
use boolean;

sub eban{
    my($n) = @_;
    return false if $n =~ m/^1.*/;
    return false if $n =~ m/.*1$/;
    return false if $n =~ m/.*3$/;
    return false if $n =~ m/.*5$/;
    return false if $n =~ m/.*7$/;
    return false if $n =~ m/.*8$/;
    return false if $n =~ m/.*9$/;
    return false if $n =~ m/2[0-9]$/;
    return false if $n =~ m/7[0-9]$/;
    return false if $n =~ m/8[0-9]$/;
    return false if $n =~ m/9[0-9]$/;
    return true;
}

sub eban_under_100{
    my @eban;
    my $x = 1;
    do{
        push @eban, $x if eban($x);
        $x++;
    }while($x <= 100);
    return @eban;
}

MAIN:{
    print join(", ", eban_under_100()) . "\n";
}