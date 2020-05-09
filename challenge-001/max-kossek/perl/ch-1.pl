#!/usr/bin/perl;
use strict;
use warnings;

my $input_string = 'Perl Weekly Challenge';
my $count_e = $input_string =~ s/e/E/g;
print "$input_string - Number of e's replaced: $count_e\n";

__END__
