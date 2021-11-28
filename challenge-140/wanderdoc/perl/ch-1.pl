#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two decimal-coded binary numbers, $a and $b. Write a script to simulate the addition of the given binary numbers. The script should simulate something like $a + $b. (operator overloading)
Example 1 Input: $a = 11; $b = 1; Output: 100
Example 2 Input: $a = 101; $b = 1; Output: 110
Example 3 Input: $a = 100; $b = 11; Output: 111
=cut








package BinNum
{
     use Carp;
     use overload (
          "+" => \&add_binary, 
          '""' => \&print_binary, 
          'nomethod' => sub {croak 'no valid operation';});

     sub new
     {
          my $class = shift;
          my $value = shift;
          return bless \$value => $class;
     }


     sub add_binary
     {
          my ($first, $second) = @_;
          my $first_d =  oct("0b$first" );


          my $second_d = oct("0b$second"); 
          my $output_d = $first_d + $second_d; 
          my $output = sprintf("%b", $output_d);

          return bless \$output => ref($first);
     }
     


     sub print_binary
     {
          my $self = shift; 
          return $$self;
     }

     1;
}

package main;

my $val_1 = BinNum->new(11);
my $val_2 = BinNum->new(1);
print $val_1 + $val_2, $/;

$val_1 = BinNum->new(101); 
$val_2 = BinNum->new(1); 
print $val_1 + $val_2, $/;

$val_1 = BinNum->new(100); 
$val_2 = BinNum->new(11); 
print $val_1 + $val_2, $/;

$val_1 = BinNum->new(111111); 
$val_2 = BinNum->new(111111); 
print $val_1 + $val_2, $/;

$val_1 = BinNum->new(101010101); 
$val_2 = BinNum->new(101010101); 
print $val_1 + $val_2, $/;