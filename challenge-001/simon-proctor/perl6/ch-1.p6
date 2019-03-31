my $s = "Perl Weekly Challenge";
my $c = 0;
$c++ while $s ~~ s!e!E!;
say "Updated $s";
say "Number of matches : $c";
