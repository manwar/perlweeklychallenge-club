#!/usr/bin/env perl
use warnings;
use strict;
use List::Util;
use Data::Dumper;
my $input=join "", @ARGV;
$input="[2,7], [3,9], [10,12], [15,19], [18,22]" unless @ARGV;

$input =~ s/\s+//g;
my @ranges;
while ($input =~ /\[(\d+)\,(\d+)\]/g) {
	push @ranges , {start=>int($1), end=>int($2)};
}
@ranges=sort { $a->{start} > $b->{start} } @ranges;
printf "Input Ranges: %s\n",join ",", map { sprintf("[%s,%s]",$_->{start}, $_->{end})} @ranges;

my @merged;

while (@ranges) {
        my $test=shift @ranges;
        @ranges= map {
                do {

                        my $c1=($_->{start} <= $test->{start}) && ($test->{start} <= $_->{end});
                        my $c2=($test->{start} <= $_->{start}) && ($_->{start} <= $test->{end});
                        if ($c1||$c2) {
                                $test->{start}=List::Util::min $_->{start}, $test->{start};
                                $test->{end}=List::Util::max $_->{end}, $test->{end};
                                ();
                        }
                        else {
                                $_;
                        }
                }
        } @ranges;

        push @merged, $test;
}
printf "Merged Ranges: %s\n",join ",", map { sprintf("[%s,%s]",$_->{start}, $_->{end})} @merged;
