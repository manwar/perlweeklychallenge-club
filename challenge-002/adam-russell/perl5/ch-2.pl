use strict;
use warnings; 
##
# Challenge #2
# Write a script that can convert integers to and from a base35 representation, using the characters 0-9 and A-Y.
##
use constant BASE => 35;  
use constant OFFSET => 87;  
use constant EXAMPLE_0 => "7";
use constant EXAMPLE_1 => "11";
use constant EXAMPLE_2 => "1A7H";
use constant EXAMPLE_3 => "7";
use constant EXAMPLE_4 => "36";
use constant EXAMPLE_5 => "55387";

my(@digits,$converted); 
@digits = split(//,EXAMPLE_0);
$converted = base35_to_base10(\@digits);  
print "(base 35 -> base 10) ". EXAMPLE_0 . " -> $converted\n";

@digits = split(//,EXAMPLE_1);
$converted = base35_to_base10(\@digits);  
print "(base 35 -> base 10) ". EXAMPLE_1 . " -> $converted\n";

@digits = split(//,EXAMPLE_2);
$converted = base35_to_base10(\@digits);  
print "(base 35 -> base 10) ". EXAMPLE_2 . " -> $converted\n";

$converted = base10_to_base35(EXAMPLE_3);  
print "(base 10 -> base 35) ". EXAMPLE_3 . " -> $converted\n";

$converted = base10_to_base35(EXAMPLE_4);  
print "(base 10 -> base 35) ". EXAMPLE_4 . " -> $converted\n";

$converted = base10_to_base35(EXAMPLE_5);  
print "(base 10 -> base 35) ". EXAMPLE_5 . " -> $converted\n";

sub base10_to_base35{
    my $number = shift(@_);
    if($number == 0){
        return "";    
    }  
    my $value = $number % BASE; 
    $number = int($number / BASE);  
    
    $value = uc(chr($value + OFFSET)) if $value >= 10;  
    my $r = base10_to_base35($number);  
    return $r .= $value;
} 

sub base35_to_base10{
    my $digits = shift(@_);
    my $length = @{$digits};  
    my $current_digit = shift(@{$digits}); 
    my $value; 
    if($current_digit =~ m/\d/){
        $value = $current_digit;   
    } 
    else{
        $value = ord(lc($current_digit)) - OFFSET;   
    }  
    if($length == 1){
        return $value;    
    }  
    else{
        return $value * (BASE ** ($length-1)) + base35_to_base10($digits);  
    }  
} 
