use 5.026;

use strict;
use warnings;
no  warnings 'syntax';

#
# Assume the list of letters are the arguments. Read the list
# of words from STDIN
#
my %letters;
$letters {$_} ++ for "@ARGV" =~ /[a-z]/g;

WORD: while (<STDIN>) {
        chomp;
        next if /[^a-z]/;
        my %l;
        $l {$_} ++ for split //;
        foreach my $c (keys %l) {
            no warnings 'uninitialized';
            next WORD if $letters {$c} < $l {$c};
        }
        say;
}

__END__
