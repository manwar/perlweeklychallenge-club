#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to declare a variable or constant and print its location in the memory.
=cut

my $var = 'Test';
my $address = sprintf("%p", $var);
printf("%d %s$/", hex($address), $address);