use strict;
use warnings;
use feature "say";

my $max = shift;
$max = 4 unless defined $max;
my $file_in = "./words.txt";
open my $IN, "<", $file_in or die "unable to open $file_in";
while (my $line = <$IN>) {
    chomp $line;
    next if length $line < 2 or length $line > 8;
    next if $line =~ /[^a-folist]/;
    my $word = $line;
    next if ($word =~ tr/olist/01157/) > $max;
    say $line, " -> 0x", $word;
}
