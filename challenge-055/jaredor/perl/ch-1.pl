#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum max);
use List::MoreUtils qw(indexes);

my $binstr = $ARGV[0];

die "Need a string of 0s and 1s, not this: -->$binstr<--\n"
  if $binstr !~ /\A [01]+ \Z/xms;

my ( $begstr, $midstr, $endstr ) = ( $binstr, '', '' );
( $begstr, $midstr, $endstr ) = ( $binstr =~ /\A(1*)(.*0)(1*)\Z/xms )
  if $binstr =~ /0/;

my $i = 0;
my @groups =
  map { ( /0/ ? 1 : -1 ) * length($_) }
  grep { $i = !$i } ( $midstr =~ /((.)\g{-1}*)/g );

my ( $L, $max ) = ( length($begstr), 0 );
my @answers;
while (@groups) {
    my $total = 0;
    my @tot = map { $total += $_ } @groups; # List::Util reductions
    $max = max( $max, max @tot );
    for my $idx (indexes { $_ == $max } @tot) {
        my $R = -1 + sum map { abs $_ } $L, @groups[ 0 .. $idx ];
        push @answers, [ $L, $R, $max];
    }
    $L += sum map { abs $_ } splice(@groups, 0, 2);
}
@answers = grep { pop @$_ == $max } @answers;

my $header1 = "INPUT STRING : $binstr";
print "\n$header1\n\n";

my $header2 = 'Maximal Flip Pairs';
print "$header2\n", '.' x length $header2, "\n";
print "NONE\n" unless @answers;

while (@answers) {
    my ( $L, $R, $flipped, ) = (@{ shift @answers }, $binstr);
    substr( $flipped, $L, $R - $L + 1 ) =~ tr/01/10/;
    print "(L=$L, R=$R) : $flipped\n";
}
