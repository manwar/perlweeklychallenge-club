#!/usr/bin/env perl

# Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.
# Example
# 
# IV + V     => IX
# M - I      => CMXCIX
# X / II     => V
# XI * VI    => LXVI
# VII ** III => CCCXLIII
# V - V      => nulla (they knew about zero but didn't have a symbol)
# V / II     => non potest (they didn't do fractions)
# MMM + M    => non potest (they only went up to 3999)
# V - X      => non potest (they didn't do negative numbers)

use strict;
use warnings;
use POSIX qw/floor/;
use Test::More;
use Data::Dumper;

my $cases = [
    ['IV',  '+',  'V'  ], # 0
    ['M',   '-',  'I'  ], # 1
    ['X',   '/',  'II' ], # 2
    ['XI',  '*',  'VI' ], # 3
    ['VII', '**', 'III'], # 4
    ['V',   '-',  'V'  ], # 5
    ['V',   '/',  'II' ], # 6
    ['MMM', '+',  'M'  ], # 7
    ['V',   '-',  'X'  ], # 8
];

sub roman2arabic
{
    my $r = shift;

    my $sum = 0;
    my @chars = split //, $r;
    for (my $i=0; $i < @chars; ++$i) {
        my $c = $chars[$i];
        if ($c eq 'I') {
            ++$sum;
        } elsif ($c eq 'V') {
            $sum += (($sum == 0 || $chars[$i-1] ne 'I') ?    5 :   3);
        } elsif ($c eq 'X') {
            $sum += (($sum == 0 || $chars[$i-1] ne 'I') ?   10 :   8);
        } elsif ($c eq 'L') {
            $sum += (($sum == 0 || $chars[$i-1] ne 'X') ?   50 :  30);
        } elsif ($c eq 'C') {
            $sum += (($sum == 0 || $chars[$i-1] ne 'X') ?  100 :  80);
        } elsif ($c eq 'D') {
            $sum += (($sum == 0 || $chars[$i-1] ne 'C') ?  500 : 300);
        } elsif ($c eq 'M') {
            $sum += (($sum == 0 || $chars[$i-1] ne 'C') ? 1000 : 800);
        } else {
            undef $sum;
        }
    }
	return $sum;
}

sub arabic2roman
{
    my $n = shift;

    return undef if $n < 0 || 4000 <= $n;

	my @nums = qw/I V X L C D M/;
	my $count = 0;
	my $res = '';

    my @chars = split //, $n;
    for (my $i=$#chars; $i >= 0; --$i) {
		my $r;
        my $num = $chars[$i];
		if (1 <= $num && $num < 4) {
			$r .=  ($nums[$count] x $num); 
			$count += 2;
		} elsif (4 <= $num && $num < 9) {
			$count += 2;
			if ($num == 4) {
				$r .= $nums[$count - 2];
			}
			$r .= $nums[$count - 1];
			$r .= ($nums[$count - 2] x (($num - 5) < 0 ? 0 : ($num - 5))); 

		} elsif ($num == 9) {
			$count += 2;
			$r .= $nums[$count - 2] . $nums[$count];
		} elsif ($num == 0) {
			$count += 2;
		}
		$res = $r . $res;
    }

    return $res;
}

sub roman_maths
{
    my $exp = shift;

    my ($left, $op, $right) = @$exp;

    my $l = roman2arabic($left);
    my $r = roman2arabic($right);
    
    my $res;
    if ($op eq '+') {
        $res = $l + $r;
    } elsif ($op eq '-') {
        $res = $l - $r;
    } elsif ($op eq '*') {
        $res = $l * $r;
    } elsif ($op eq '/') {
        $res = $l / $r;
    } elsif ($op eq '**') {
        $res = $l ** $r;
    } else {
        print "Invalid operator: $op\n";
		return;
    }
    if ($res == 0) {
        $res = 'nulla';
    } elsif ($res < 0 || $res > 3999 || $res != floor($res)) {
        $res = 'non potest';
    } else {
        $res = arabic2roman($res);
    }
    return $res;
}

is(roman_maths($cases->[0]), 'IX',         'IV + V');
is(roman_maths($cases->[1]), 'CMXCIX',     'M - I');
is(roman_maths($cases->[2]), 'V',          'X / II');
is(roman_maths($cases->[3]), 'LXVI',       'XI * VI');
is(roman_maths($cases->[4]), 'CCCXLIII',   'VII ** III');
is(roman_maths($cases->[5]), 'nulla',      'V - V');
is(roman_maths($cases->[6]), 'non potest', 'V / II');
is(roman_maths($cases->[7]), 'non potest', 'MMM + M');
is(roman_maths($cases->[8]), 'non potest', 'V - X');
done_testing();

exit 0;
