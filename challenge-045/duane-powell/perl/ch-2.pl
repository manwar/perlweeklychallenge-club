#!/usr/bin/perl
use warnings;
use strict;

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/ Task #2

system("cat $0");

__END__

./perl ch-2.pl
#!/usr/bin/perl
use warnings;
use strict;
system("cat $0");

perl ch-2.pl | diff - ch-2.pl

