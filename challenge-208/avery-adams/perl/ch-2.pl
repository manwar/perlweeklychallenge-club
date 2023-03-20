use strict;
use v5.10;

my $index;
my ($duplicate, $missing);
foreach (@ARGV) {
    if (!defined($index)) {$index = 1 and next}
    if ($_ == $ARGV[$index - 1]) {$duplicate = $_}
    if ($_ != $ARGV[$index - 1] + 1) {$missing = $ARGV[$index - 1] + 1}
    $index++;
}
defined($duplicate) && defined($missing) ? say ("Duplicate is $duplicate", "\n", "Missing is $missing") : say -1;
