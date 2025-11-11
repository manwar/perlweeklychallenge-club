#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 346 Task 2  Magic Expression
#=============================================================================
# You are given a string containing only digits and a target integer.
# Write a script to insert binary operators +, - and * between the digits
# in the given string that evaluates to target integer.
# Example 1 Input: $str = "123", $target = 6
#           Output: ("1*2*3", "1+2+3")
# Example 2 Input: $str = "105", $target = 5
#           Output: ("1*0+5", "10-5")
# Example 3 Input: $str = "232", $target = 8
#           Output: ("2*3+2", "2+3*2")
# Example 4 Input: $str = "1234", $target = 10
#           Output: ("1*2*3+4", "1+2+3+4")
# Example 5 Input: $str = "1001", $target = 2
#           Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
#=============================================================================

use v5.42;
use feature "class"; no warnings "experimental::class";


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================
# Iterator to do permutations by counting. If there are 'base' objects, count
# in base 'base'. Take it up to 'n' choices, then return undef to signal
# the end.
class Permute {
    field $base :param //= 4;
    field $n    :param //= 3;
    field $max = $base ** ($n);

    field @c = (0) x $n;
    field $count = 0;
    field $number = 0;

    method next()
    {
        return undef if ++$number >= $max;

        my $place = 0;
        my $carry;
        while ( ($carry = (++$c[$place]  % $base)) == 0 )
        {
            $c[$place++] = 0;
        }
        return $self;
    }

    # Return the selections as reference to array.
    method val() { return $number < $max ? \@c : undef }

    method show() { "(" . join(" ", reverse(@c)) . ")" }
};
#=============================================================================

exit(!runTest()) if $DoTest;

say '(', join(', ', magic(@ARGV)->@*), ')';

#=============================================================================
sub magic($str, $target)
{
    state @OP = ("", "-", "+", "*");
    $logger->debug("@OP");

    my @s = split(//, $str);
    my @expr;

    my $count = Permute->new( base => scalar(@OP), n => $#s );

    for ( ; my $idx = $count->val ; $count->next )
    {
        my @ops = ( ( map { $OP[$_] } $count->val()->@*), "");

        use List::Util qw/mesh/;
        my $e = join("", mesh \@s, \@ops);

        # Numbers with leading zeroes don't count
        next if $e =~ m/^0\d|[^0-9]0\d/;

        my $t = eval $e;
        $logger->debug("ops:", $count->show(), " |", join("|", @ops), '|',  "expr: ", $e, "=$t");
        push @expr, $e if $t == $target;
    }

    return [sort @expr];
}

sub runTest
{
    use Test2::V0;

    is( magic("123",   6), ["1*2*3", "1+2+3"    ] , "Example 1");
    is( magic("105",   5), ["1*0+5", "10-5"     ] , "Example 2");
    is( magic("232",   8), ["2*3+2", "2+3*2"    ] , "Example 3");
    is( magic("1234", 10), ["1*2*3+4", "1+2+3+4"] , "Example 4");
    is( magic("1001",  2), ["1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"] , "Example 5");

    done_testing;
}
