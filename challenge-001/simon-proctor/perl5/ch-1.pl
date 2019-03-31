use v5.10;
use strict;

my $s = "Perl Weekly Challenge";
my $c = 0;
$c++ while $s =~ s!e!E!;
say "Updated $s";
say "Number of matches : $c";

#$s = "Perl Weekly Challenge";
#$c = 0;
#$c++ while $s ~~ s!e!E!;
#say "Updated $s";
#say "Number of matches : $c";
