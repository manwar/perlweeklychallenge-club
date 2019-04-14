use warnings;
use strict;
use Math::Prime::Util qw/Pi/;

open(my $fh, "<", $0);
my $chars;
$chars += length($_) for <$fh>;
close $fh;
print Pi($chars)."\n";
