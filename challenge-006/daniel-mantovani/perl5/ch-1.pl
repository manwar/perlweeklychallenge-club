#
# Create a script which takes a list of numbers from command line and print the same in the compact form.
# For example, if you pass “1,2,3,4,9,10,14,15,16” then it should print the compact form like “1-4,9,10,14-16”.
#
use strict;
use warnings;

my $inp = $ARGV[0];
die "Usage perl $0 <commma separated number list>"
  unless defined $inp && $inp =~ /^(\d+,?)+$/;
#
# for all numbers, calculate adjacency as:
# 0b00 no adjacent numbers
# 0b10 adjacency on lower side
# 0b01 adjacency on upper side
# 0b11 adjacency on both sides
#
my %adj;
$adj{$_} = 0 for split ',', $inp;
for my $n ( keys %adj ) {
    $adj{$n} |= 0b10 if exists $adj{ $n - 1 };
    $adj{$n} |= 0b01 if exists $adj{ $n + 1 };
}
#
# now calculate an ordered array with all numbers that have to be printed
#
my @edges = grep { $adj{$_} != 3 } sort { $a <=> $b } keys %adj;
#
# if got here, there is a first number to print
#
print $edges[0];
for my $i ( 1 .. $#edges ) {
    my $current = $edges[$i];

# if current number - 1 exists and have adjacency type '3', separator is '-', otherwise it is ','
    print exists $adj{ $current - 1 }
      && $adj{ $current - 1 } == 3 ? '-' : ',';
    print $current;
}

print "\n" if defined $inp;
