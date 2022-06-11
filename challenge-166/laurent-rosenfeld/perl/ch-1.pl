use strict;
use warnings;
use feature "say";

my $file_in = "./words.txt";
open my $IN, "<", $file_in or die "unable to open $file_in";
while (my $line = <$IN>) {
    chomp $line;
    next if length $line < 2 or length $line > 8;
    next if $line =~ /[^a-folist]/;
    say "$_ -> 0x", tr/olist/01157/r for $line;
}
