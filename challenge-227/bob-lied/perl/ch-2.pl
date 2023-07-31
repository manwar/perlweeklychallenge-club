#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Roman Maths 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to handle a 2-term arithmetic operation expressed in Roman
# numeral.  Examples:
#   IV + V     => IX
#   M - I      => CMXCIX
#   X / II     => V
#   XI * VI    => LXVI
#   VII ** III => CCCXLIII
#   V - V      => nulla (they knew about zero but didn't have a symbol)
#   V / II     => non potest (they didn't do fractions)
#   MMM + M    => non potest (they only went up to 3999)
#   V - X      => non potest (they didn't do negative numbers)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub rom2dec($r)
{
}

sub dec2rom($d)
{
}

sub mathRomana($expr)
{
    my ($r1, $op, $r2) = split('', $expr);
    my ($t1, $t2) = map { rom2dec($_) } $r1, $r2;

    my $answer;
    if ( $op eq '+' )
    {
        $answer = $t1 + $t2;
    }
    elsif ( $op eq '-' )
    {
        $answer = $t1 - $t2;
        return 'nulla' if ( $answer == 0 );
        return 'non potest' if  ( $answer < 0 );
    }
    elsif ( $op eq '/' )
    {
        $answer = $t1 / $t2;
        # Don't do fractions
        return 'non potest' if ( int($answer) != $answer );
    }
    elsif ( $op eq '*' )
    {
        $answer = $t1 * $t2;
    }
    elsif ( $op eq '**' )
    {
        $answer = $t1 ** $t2;
    }
    return 'non potest' if $answer > 3999;
    return dec2rom($answer);
}

sub runTest
{
    use Test2::V0;

    my %t = ( 'IV + V'     => 'IX',
              'M - I'       => 'CMXCIX',
              'X / II'     => 'V',
              'XI * VI'    => 'LXVI',
              'VII ** III' => 'CCCXLIII',
              'V - V'      => 'nulla',
              'V / II'     => 'non potest',
              'MMM + M'    => 'non potest',
              'V - X'      => 'non potest',
          );
    for my $expr ( keys %t )
    {
        is( mathRomana($expr), $t{$expr}, "Example $expr");
    }

    done_testing;
}
