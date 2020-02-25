use strict;
use warnings;

my $progr = "./$0";
open my $IN, "<", $progr or die "Unable to open $progr $!";
print while <$IN>;
close $IN;
