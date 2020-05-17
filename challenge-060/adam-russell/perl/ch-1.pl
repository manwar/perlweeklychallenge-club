use strict;
use warnings;
##
# Write a script that accepts a number and returns 
# the Excel Column Name it represents and vice-versa.
## 
sub number_to_column{
    my($n) = @_;
    my $s = "";
    while($n > 0){
        $s .= "A" if $n > 26;
        $s .= chr($n + 64) if $n < 26; 
        $n -= 26; 
    } 
    return $s; 
}

sub column_to_number{
    my($s) = @_;
    my $n = 0;
    for my $c (split(//, $s)){
        $n += 1 if $c eq "A" && length($s) == 1;
        $n += 26 if $c eq "A" && length($s) != 1;
        $n += ord($c) - 64 if $c ne "A";
    } 
    return $n; 
}

MAIN:{
    print number_to_column(28) . "\n"; 
    print number_to_column(80) . "\n"; 
    print number_to_column(30) . "\n"; 
    print column_to_number("A") . "\n"; 
    print column_to_number("Z") . "\n"; 
    print column_to_number("AB") . "\n"; 
    print column_to_number("AAAZ") . "\n"; 
}  
