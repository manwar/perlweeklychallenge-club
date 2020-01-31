#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/
# Task #2
# Source Dumper
# Write a script that dumps its own source code.
# For example, say, the script name is ch-2.pl then the following command should returns nothing.
#
# $ perl ch-2.pl | diff - ch-2.pl

use strict;
use warnings;
use v5.10;

# This is my quine!

my @s = (
q&&,
q&say <<'EOT';&,
q&#!/usr/bin/perl&,
q&&,
q&# https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/&,
q&# Task #2&,
q&# Source Dumper&,
q&# Write a script that dumps its own source code.&,
q&# For example, say, the script name is ch-2.pl then the following command should returns nothing.&,
q&#&,
q&# $ perl ch-2.pl | diff - ch-2.pl&,
q&&,
q&use strict;&,
q&use warnings;&,
q&use v5.10;&,
q&&,
q&# This is my quine!&,
q&EOT&,
q&&,
q&say 'my @s = (';&,
q&foreach my $line (@s) {&,
q&    say 'q'.chr(38).$line.chr(38).','&,
q&}&,
q&say ');';&,
q&&,
q&foreach my $line (@s) {&,
q&    say $line&,
q&}&,
q&&,
q&say <<'EOT';&,
q&__END__&,
q&&,
q&./ch-2.pl | diff - ch-2.pl&,
q&EOT&,
q&&,
);

say <<'EOT';
#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/
# Task #2
# Source Dumper
# Write a script that dumps its own source code.
# For example, say, the script name is ch-2.pl then the following command should returns nothing.
#
# $ perl ch-2.pl | diff - ch-2.pl

use strict;
use warnings;
use v5.10;

# This is my quine!
EOT

say 'my @s = (';
foreach my $line (@s) {
    say 'q'.chr(38).$line.chr(38).','
}
say ');';

foreach my $line (@s) {
    say $line
}

say <<'EOT';
__END__

./ch-2.pl | diff - ch-2.pl
EOT

__END__

./ch-2.pl | diff - ch-2.pl

