#!/r/bin/perl
use strict;
use warnings;

# with this script you can add 2 binary numbers and get their sum as binary number
# https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK1

# get input
print "decimal number a: ";
my $a = <STDIN>;
chomp $a;
my $power_n = 0;
my $a_binary += decimal_to_binary ( $power_n, $a );
printf ( "binary number a: %i\n", $a_binary );

# convert dec to bin
sub decimal_to_binary {
    my ( $power, $decimal_number ) = @_;
    if ( $decimal_number == 0 ) {
        return 0;
        #exit;
    }
    elsif ( $decimal_number == 2**$power ) {
        print "if\n$decimal_number\n$power\n\n";
        return 10**$power;
        #exit;
    }
    elsif ( $decimal_number <= 2**($power+1) ) {
        $power++;
        decimal_to_binary ( $power, $decimal_number );
        print "elsif\n$decimal_number\n$power\n\n";
    }
    else {
        return 10**($power+1);
        $decimal_number -= 2**($power+1);
        $power = 0;
        print "else\n$decimal_number\n$power\n\n";
        decimal_to_binary ( $power, $decimal_number );
    }
}