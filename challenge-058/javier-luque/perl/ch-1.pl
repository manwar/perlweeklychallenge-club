#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;
use version;
use Data::Dumper;

say '   v1   v2    Result';
say '------ ------ ------';
say '0.1   < 1.1   ' .  compare('0.1','1.1');
say '2.0   > 1.2   ' .  compare('2.0','1.2');
say '1.2   < 1.2_5 ' .  compare('1.2','1.2_5');
say '1.2.1 > 1.2_1 ' .  compare('1.2.1','1.2_1');
say '1.2.1 = 1.2.1 ' .  compare('1.2.1','1.2.1');
say '1_0   > 1     ' .  compare('1_0','1');
say '10    > 1.0   ' .  compare('10','1.0');
say '1.1.1 < 1.2.1 ' .  compare('1.1.1','1.2.1');

sub compare {
    my ($v1, $v2) = @_;

    # Split into digits or alpha
    my ($v1_d, $v1_a) = parse($v1);
    my ($v2_d, $v2_a) = parse($v2);

    while (scalar(@$v1_d) || scalar(@$v2_d) ) {
    	my $d1 = shift(@$v1_d);
    	my $d2 = shift(@$v2_d);
    	return 0  if (!defined($d1) && !defined($d2));
    	return 1  if (defined($d1)  && !defined($d2));
    	return -1 if (!defined($d1) && defined($d2));
    	return 1 if ($d1 > $d2);
    	return -1 if ($d1 < $d2);
    }

    return  0 if (!defined($v1_a) && !defined($v2_a));
    return  1 if (defined($v1_a)  && !defined($v2_a));
    return -1 if (!defined($v1_a) && defined($v2_a));

    return ($v1_a > $v2_a) ?  1 :
           ($v1_a < $v2_a) ? -1 : 0;
}

sub parse {
    my $version = shift;

    my @digits = split('\.', $version);
    my ($last_digit, $alpha) = split('_', pop(@digits));
    push @digits, $last_digit;

    return \@digits, $alpha;
}
