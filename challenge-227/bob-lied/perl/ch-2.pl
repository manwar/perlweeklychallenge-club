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

my %VAL = ( I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000 );

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub rom2dec($r)
{
    my @rom = split(//, $r); # Roman digits as an array
    my $dec = 0;
    while ( my $rd = shift @rom )
    {
        my $rv = $VAL{$rd};
        my $next = ( @rom ? $VAL{$rom[0]} : 0 );
        if ( $next > $rv )
        {
            $dec += $next - $rv;
            shift @rom;
        }
        else
        {
            $dec += $rv;
        }
    }
    return $dec;
}

sub dec2rom($d)
{
    # Instead of trying to figure out the logic for when to subtract,
    # let's just list the possibilities.  State variable because we
    # only need one copy of this.
    state %RomVal = (
        thousand => [ "", qw(M MM MMM ) ],
        hundred  => [ "", qw(C CC CCC CD D DC DCC DCCC CM) ],
        ten      => [ "", qw(X XX XXX XL L LX LXX LXXX XC) ],
        one      => [ "", qw(I II III IV V VI VII VIII IX) ],
    );
    my $rom = "";

    # Roman numerals group from largest to smallest, so start with
    # the thousands.
    my $n = int( $d / 1000 );
    $rom .= $RomVal{thousand}->[$n];
    $d -= 1000 * $n;

    $n = int( $d / 100 );
    $rom .= $RomVal{hundred}->[$n];
    $d -= 100 * $n;

    $n = int( $d / 10 );
    $rom .= $RomVal{ten}->[$n];
    $d -= 10 * $n;

    $rom .= $RomVal{one}->[$d];

    return $rom;
}

sub mathRomana($expr)
{
    my ($r1, $op, $r2) = split(' ', $expr);
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

    is( rom2dec("I"),     1, "rom2dec 1");
    is( rom2dec("II"),    2, "rom2dec 2");
    is( rom2dec("III"),   3, "rom2dec 3");
    is( rom2dec("IV"),    4, "rom2dec 4");
    is( rom2dec("V"),     5, "rom2dec 5");
    is( rom2dec("VI"),    6, "rom2dec 6");
    is( rom2dec("VII"),   7, "rom2dec 7");
    is( rom2dec("VIII"),  8, "rom2dec 8");
    is( rom2dec("IX"),    9, "rom2dec 9");
    is( rom2dec("X"),    10, "rom2dec 10");
    is( rom2dec("XLII"), 42, "rom2dec 42");
    is( rom2dec("LXII"), 62, "rom2dec 52");
    is( rom2dec("MCMXCIX"), 1999, "rom2dec 1999");

    is( dec2rom(   1),  "I",  "dec2rom 1");
    is( dec2rom(   2), "II",  "dec2rom 2");
    is( dec2rom(   4), "IV",  "dec2rom 4");
    is( dec2rom(   5),  "V",  "dec2rom 5");
    is( dec2rom(   6), "VI",  "dec2rom 6");
    is( dec2rom(   9), "IX",  "dec2rom 9");
    is( dec2rom(  10),  "X",  "dec2rom 10");
    is( dec2rom(  11), "XI",  "dec2rom 11");
    is( dec2rom(  15), "XV",  "dec2rom 15");
    is( dec2rom(  19), "XIX", "dec2rom 19");
    is( dec2rom(  1999), "MCMXCIX", "dec2rom 1999");
    is( dec2rom(  3999), "MMMCMXCIX", "dec2rom M999");

    my %t = ( 'IV + V'     => 'IX',
              'M - I'      => 'CMXCIX',
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
