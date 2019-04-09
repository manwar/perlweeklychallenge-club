use strict;
use warnings;

while (my $n = <DATA>)
{
    chomp $n;

    if ($n =~  / ^  \+?          \.  \d+  $ /x       ||
        $n =~ s/ ^ (\+?) 0* (\d+ \.? \d*) $ /$1$2/x)
    {
        print "$n\n";
    }
    else
    {
        print "$n is not a positive number\n";
    }
}

__DATA__
00012345
+0678
0000090.123
+00456.789
0.123
000.123
0
00
.123
-01
