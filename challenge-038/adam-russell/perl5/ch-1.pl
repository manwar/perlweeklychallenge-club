use strict;
use warnings;
##
# Create a script to accept a 7 digits number, where 
# the first number can only be 1 or 2. The second and 
# third digits can be anything 0-9. The fourth and 
# fifth digits corresponds to the month i.e. 01,02,03,...,11,12. 
# And the last 2 digits respresents the days in the 
# month i.e. 01,02,03,...,29,30,31. Your script should validate 
# if the given number is valid as per the rule and then 
# convert into human readable format date.
# RULES
# 1) If 1st digit is 1, then prepend 20 otherwise 19 to the 
#    2nd and 3rd digits to make it 4-digits year.
# 2) The 4th and 5th digits together should be a valid month.
# 3) The 6th and 7th digits together should be a valid day 
#    for the above month.
##
use boolean; 
sub is_valid{
    my($x) = @_;
    $x =~ m/([1-2]{1})([0-9]{2})(0[1-9]{1}|1[012]{1})(0[1-9]{1}|1[012]{1}|2[0-9]{1})/; 
    return $x, $1, $2, $3, $4; 
} 

sub transform{
    my($a, $b, $c, $d) = @_;
    if($a == 1){
        $a = "20$a"; 
    }
    else{
        $a = "19$b"; 
    }  
    return "$a-$c-$d"; 
}

MAIN:{
    while(my $x = <DATA>){
        my ($valid, @fields) = is_valid($x);
        unless(!$valid){
            print transform(@fields) . "\n"; 
        }
        else{
            print "invalid: $x\n"; 
        }  
    } 
} 

__DATA__
2230120
