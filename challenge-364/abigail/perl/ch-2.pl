#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (<>) {
    # No need to do anything with the 'G'
    print s/\Q()/o/gr      #  Replace all '()'   with 'o'
       =~ s/\Q(al)/al/gr;  #  Replace all '(al)' with 'al'
}

__END__
