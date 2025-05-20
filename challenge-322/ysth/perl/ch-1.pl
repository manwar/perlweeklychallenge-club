use 5.036;

my ($string, $group_size) = @ARGV;

# yes, you can do this without the double reverse, but not as efficiently
say scalar reverse((reverse $string =~ y/-//dr) =~ s/.{$group_size}\K(?!\z)/-/sgr)
