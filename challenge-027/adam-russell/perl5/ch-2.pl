use strict;
use warnings;
##
# Write a script that allows you to capture/display historical data. 
# It could be an object or a scalar.
## 
use Audit; 
use Class::Hash; 

my $test0;
$test0 = 2;
$test0 = 3;

Audit::print_log(); 
Audit::clear_log(); 

my $test1 = new Class::Hash(A => "B");
$test1 = new Class::Hash(B => "C");
$test1 = new Class::Hash(C => "D");
#Audit::pretty_print_log(); 
Audit::print_log(); 
