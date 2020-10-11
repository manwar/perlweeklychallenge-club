#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

chomp (my $str1 = <>);
chomp (my $str2 = <>);

#
# Sort the strings by lenght, so $str1 isn't longer than $str2.
#
($str1, $str2) = ($str2, $str1) if length $str2 < length $str1;

#
# Find a substring which cannot be part of either string,
# nor of its concatenation.
#
my $sep = "\x00" x (1 + length ($str1) + length ($str2));

#
# Now, use a regular expression to find common base strings.
#
$_ = "$str1$sep$str2";
/^ (.+) \1*     # Find base strings of $str1
   $sep         # Match the separator
   \1+ $        # Must be base string for $str2
   (?{say $1})  # Print it
   (*FAIL)      # Backtrack so we can try other base strings.
/x;

__END__
