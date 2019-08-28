#!/usr/bin/env perl

=head1 SYNOPSIS

Task:
Create a script that prints nth order forward difference series. You should be a 
able to pass the list of numbers and order number as command line parameters.

Usage:
    $ perl ch-1.pl --order=1 5 9 2 8 1 6

=cut

use strict;
use warnings;
use feature 'say';

use Getopt::Long;

my $order;
GetOptions( 'order=i' => \$order ) or die;

my @numbers = @ARGV;

foreach my $order ( 1 .. $order ) {
    @numbers = map { $numbers[ $_ ] - $numbers[ $_ - 1 ] } 1 .. $#numbers;
    say "$order: " . join(', ', @numbers);
    last if @numbers == 1;
}

