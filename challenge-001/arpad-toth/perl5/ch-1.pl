#!/usr/bin/perl -w

use strict;

=pod

=head1

Challenge #1
Write a script to replace the character 'e' with 'E' in the string 'Perl Weekly Challenge'. Also print the number of times the character 'e' found in the string.

=cut

my $string = 'Perl Weekly Challenge';
my $num=($string=~ tr/e/E/);
print "'e' was replaced $num times with 'E' in '$string'\n";

exit;
