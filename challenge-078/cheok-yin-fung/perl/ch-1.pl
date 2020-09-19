#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku
#          #078 Task 1 Leader Element
# Usage: ch-1.pl @A

my @A;

if ($ARGV[0]) {@A = @ARGV;} else {@A = (9, 10, 7, 5, 6, 1);}
my @ans = ();

my @CA = @A;
my $max = -10000;

for (reverse @CA) {
    $s = pop @CA;
    if ($s > $max) {
        unshift @ans, $s;
        $max = $s;
    }
}

print "\n";
print join ",", @ans;
print "\n";
