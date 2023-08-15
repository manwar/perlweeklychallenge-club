use strict; use warnings;

sub digits { "@_" =~ /\d/g }

my @input = @ARGV ? @ARGV : (1,24,51,60);
my @output = digits(@input);
print "@output\n";
