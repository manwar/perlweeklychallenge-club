use strict;
use warnings;
##
# Write a script to demonstrate Reverse Polish notation(RPN).     
##
use Rpn;
use constant RPN_ADD => "10 8 + \n";
use constant RPN_SUBTRACT => "18 66 - \n";
use constant RPN_MULTIPLY => "10 8 * \n";
use constant RPN_DIVIDE => "52 2 / \n";

MAIN:{
    my $parser = new Rpn();
    $parser->parse(RPN_ADD); 
    $parser->parse(RPN_SUBTRACT); 
    $parser->parse(RPN_MULTIPLY); 
    $parser->parse(RPN_DIVIDE); 
}   
