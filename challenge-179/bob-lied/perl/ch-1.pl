#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 179 Task 1 Ordinal Number Spelling
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive number, $n.
# Write a script to spell the ordinal number.
# Examples
#   11 => eleventh
#   62 => sixty-second
#   99 => ninety-ninth
#=============================================================================

use v5.36;

use builtin qw/ceil floor indexed/;
no warnings 'experimental';

my @Ones = qw( zero one two three four five six seven eight nine);
my @Oneth = qw( zeroth first second third fourth fifth sixth
                seventh eighth ninth );

my @Teen = qw(ten eleven twelve thirteen fourteen fifteen sixteen
              seventeen eighteen nineteen);
my @Teenth = map { "${_}th" } @Teen;
$Teenth[2] = "twelfth";

my @Tens = qw( zero ten twenty thirty forty fifty sixty seventy eighty ninety );
my @Tenthieth = map { (my $th = $_) =~ s/y\z/ie/; "${th}th" } @Tens;

my @BigName = qw(none thousand million billion trillion quatrillion quintillion
             sextillion septillion octillion nonillion decillion );

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say asOrdinalString($_) for @ARGV;


# Returns pairs of 3-digit values and group names, like [321,million][456,thousand]
sub groupThree($n)
{
    my @group;
    my $numGrp = ceil(length($n) / 3);
    for ( my $i = 0 ; $i < $numGrp ; $i++ )
    {
        unshift @group, [ substr($n, -3*($i+1), 3), $BigName[$i] ];
    }
    return \@group;
}

sub asOrdinalString($n)
{
    my $str;
    my $group = groupThree($n);

    # For each group of three, form an ordinal number for the least
    # group and a cardinal number with its name for the higher groups.
    my @parts = map {
                    my ($val, $grpName) = $_->@*;
                    $grpName eq 'none'
                            ?   ordinal($val)
                            : (cardinal($val) . " $grpName")
                 } $group->@* ;

    # Handle things like 7_000_444 and 1000 -- don't keep things
    # like "zero thousand" or "one thousand zeroth"
    if ( @parts > 1 )
    {
        @parts = grep !/zero/, @parts;
        if ( ($n % 1000 ) == 0 )
        {
            # If we have a round number, we've stripped away
            # the 'zeroth' string at the end, so we have to
            # correct it by adding 'th' back to the end.
            $parts[-1] .= "th";
        }
    }

    $str = join(' ', @parts);
    return $str;
}

# Create a string for a 3-digit number.
sub cardinal($n)
{
    return "zero" if $n == 0;
    my $ones  = $n % 10;
    my $tens  = int($n / 10 ) % 10;
    my $hunds = int($n / 100 ) % 10;

    my $str;
    if ( $ones != 0 )
    {
        $str = ( $tens == 1 ? $Teen[$ones] : $Ones[$ones] );
    }
    elsif ( $tens == 1 )
    {
        $str = ( $Tens[1] );
    }
    if ( $tens > 1 )
    {
        $str = ( $ones == 0 ? $Tens[$tens] : "$Tens[$tens]-$str" );
    }
    if ( $hunds != 0 )
    {
        $str = ( $n %100 == 0 ? "$Ones[$hunds] hundred" : "$Ones[$hunds] hundred $str" );
    }
    return $str;
}

# Create an ordinal string for a three-digit number.
sub ordinal($n)
{
    return "zeroth" if $n == 0 ;

    my $ones  = $n % 10;
    my $tens  = int($n / 10 ) % 10;
    my $hunds = int($n / 100 ) % 10;

    my $str;

    if ( $ones != 0 )
    {
        $str = ( $tens == 1 ? $Teenth[$ones] : $Oneth[$ones] );
    }
    elsif ( $tens == 1 )
    {
        $str = $Tenthieth[$tens];
    }
    if ( $tens > 1 )
    {
        $str = ( $ones == 0 ? $Tenthieth[$tens] : "$Tens[$tens]-$str" );
    }
    if ( $hunds != 0 )
    {
        $str = ( $n %100 == 0 ? "$Ones[$hunds] hundredth" : "$Ones[$hunds] hundred $str" );
    }
    return $str;
}

sub runTest
{
    use Test2::V0;

    is( groupThree(1),         [ [  1, "none"] ], "Grouping 1");
    is( groupThree(321),       [ [321, "none"] ], "Grouping 321");
    is( groupThree(4321),      [ [  4, "thousand"],[321,'none'] ], "Grouping 4321");
    is( groupThree(7654321),   [ [7,'million'],[654, "thousand"],[321,'none'] ], "Grouping 7654321");
    is( groupThree(1987654321),[ [  1,'billion'],
                                 [987,'million'],
                                 [654, "thousand"],
                                 [321,'none'] ], "Grouping 1987654321");
    is( groupThree(4001987654321),[ [  4,'trillion'],
                                    ['001','billion'],
                                    [987,'million'],
                                    [654, "thousand"],
                                    [321,'none'] ], "Grouping 4001987654321");


    is( ordinal( 0), "zeroth",       "ord  0");
    is( ordinal( 1), "first",        "ord  1");
    is( ordinal( 2), "second",       "ord  2");
    is( ordinal( 3), "third",        "ord  3");
    is( ordinal( 4), "fourth",       "ord  4");
    is( ordinal( 5), "fifth",        "ord  5");
    is( ordinal(10), "tenth",        "ord 10");
    is( ordinal(11), "eleventh",     "ord 11");
    is( ordinal(12), "twelfth",      "ord 12");
    is( ordinal(20), "twentieth",    "ord 20");
    is( ordinal(30), "thirtieth",    "ord 30");
    is( ordinal(40), "fortieth",     "ord 40");
    is( ordinal(50), "fiftieth",     "ord 50");
    is( ordinal(60), "sixtieth",     "ord 60");
    is( ordinal(62), "sixty-second", "ord 62");
    is( ordinal(70), "seventieth",   "ord 70");
    is( ordinal(80), "eightieth",    "ord 80");
    is( ordinal(90), "ninetieth",       "ord 90");
    is( ordinal(91), "ninety-first",    "ord 91");
    is( ordinal(92), "ninety-second",   "ord 92");
    is( ordinal(93), "ninety-third",    "ord 93");
    is( ordinal(94), "ninety-fourth",   "ord 94");
    is( ordinal(95), "ninety-fifth",    "ord 95");
    is( ordinal(96), "ninety-sixth",    "ord 96");
    is( ordinal(97), "ninety-seventh",  "ord 97");
    is( ordinal(98), "ninety-eighth",   "ord 98");
    is( ordinal(99), "ninety-ninth",    "ord 99");
    is( ordinal(100), "one hundredth",  "ord 100");
    is( ordinal(101), "one hundred first",  "ord 101");
    is( ordinal(111), "one hundred eleventh",  "ord 111");
    is( ordinal(233), "two hundred thirty-third",  "ord 233");

    is( cardinal( 0), "zero",       "card  0");
    is( cardinal( 1), "one",        "card  1");
    is( cardinal( 2), "two",       "card  2");
    is( cardinal( 3), "three",        "card  3");
    is( cardinal( 4), "four",       "card  4");
    is( cardinal( 5), "five",        "card  5");
    is( cardinal(10), "ten",     "card 10");
    is( cardinal(11), "eleven",     "card 11");
    is( cardinal(12), "twelve",      "card 12");
    is( cardinal(20), "twenty",    "card 20");
    is( cardinal(30), "thirty",    "card 30");
    is( cardinal(40), "forty",     "card 40");
    is( cardinal(50), "fifty",     "card 50");
    is( cardinal(60), "sixty",     "card 60");
    is( cardinal(62), "sixty-two", "card 62");
    is( cardinal(70), "seventy",   "card 70");
    is( cardinal(80), "eighty",    "card 80");
    is( cardinal(90), "ninety",       "card 90");
    is( cardinal(91), "ninety-one",    "card 91");
    is( cardinal(92), "ninety-two",   "card 92");
    is( cardinal(93), "ninety-three",    "card 93");
    is( cardinal(94), "ninety-four",   "card 94");
    is( cardinal(95), "ninety-five",    "card 95");
    is( cardinal(96), "ninety-six",    "card 96");
    is( cardinal(97), "ninety-seven",  "card 97");
    is( cardinal(98), "ninety-eight",   "card 98");
    is( cardinal(99), "ninety-nine",    "card 99");
    is( cardinal(100), "one hundred",  "card 100");
    is( cardinal(101), "one hundred one",  "card 101");
    is( cardinal(111), "one hundred eleven",  "card 111");
    is( cardinal(233), "two hundred thirty-three", "card 233");

    is( asOrdinalString( 0), "zeroth",       "asOrdinalString  0");
    is( asOrdinalString( 1), "first",        "asOrdinalString  1");
    is( asOrdinalString( 2), "second",       "asOrdinalString  2");
    is( asOrdinalString( 3), "third",        "asOrdinalString  3");
    is( asOrdinalString( 4), "fourth",       "asOrdinalString  4");
    is( asOrdinalString( 5), "fifth",        "asOrdinalString  5");
    is( asOrdinalString(11), "eleventh",     "asOrdinalString 11");
    is( asOrdinalString(12), "twelfth",      "asOrdinalString 12");
    is( asOrdinalString(20), "twentieth",    "asOrdinalString 20");
    is( asOrdinalString(30), "thirtieth",    "asOrdinalString 30");
    is( asOrdinalString(40), "fortieth",     "asOrdinalString 40");
    is( asOrdinalString(50), "fiftieth",     "asOrdinalString 50");
    is( asOrdinalString(60), "sixtieth",     "asOrdinalString 60");
    is( asOrdinalString(62), "sixty-second", "asOrdinalString 62");
    is( asOrdinalString(70), "seventieth",   "asOrdinalString 70");
    is( asOrdinalString(80), "eightieth",    "asOrdinalString 80");
    is( asOrdinalString(90), "ninetieth",       "asOrdinalString 90");
    is( asOrdinalString(91), "ninety-first",    "asOrdinalString 91");
    is( asOrdinalString(92), "ninety-second",   "asOrdinalString 92");
    is( asOrdinalString(93), "ninety-third",    "asOrdinalString 93");
    is( asOrdinalString(94), "ninety-fourth",   "asOrdinalString 94");
    is( asOrdinalString(95), "ninety-fifth",    "asOrdinalString 95");
    is( asOrdinalString(96), "ninety-sixth",    "asOrdinalString 96");
    is( asOrdinalString(97), "ninety-seventh",  "asOrdinalString 97");
    is( asOrdinalString(98), "ninety-eighth",   "asOrdinalString 98");
    is( asOrdinalString(99), "ninety-ninth",    "asOrdinalString 99");
    is( asOrdinalString(100), "one hundredth",  "asOrdinalString 100");
    is( asOrdinalString(101), "one hundred first",  "asOrdinalString 101");
    is( asOrdinalString(111), "one hundred eleventh",  "asOrdinalString 111");
    is( asOrdinalString(233), "two hundred thirty-third",  "asOrdinalString 233");
    is( asOrdinalString(1002003), "one million two thousand third",  "asOrdinalString 1002003");
    is( asOrdinalString(10000), "ten thousandth", "asordinalString 10000");
    is( asOrdinalString(10_164_502_713),
        "ten billion one hundred sixty-four million five hundred two thousand seven hundred thirteenth",  "asOrdinalString 1002003");


    done_testing;
}

