#!/opt/perl/bin/perl

#
# Test the solutions. Either call it with the directory name you
# want to test in, or call it as "../test.pl" from within the directory.
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

chdir shift if @ARGV;

use experimental 'signatures';

use Test::More;

my @inputs = <input*>;
foreach my $input (@inputs) {
    my $output_exp = ($input =~ s/input/output/r) . ".exp";
    my $exp        = `cat $output_exp`;
    my $got        = `./solution.pl < $input`;
    is $got, $exp, $input;
}

done_testing;


__END__
