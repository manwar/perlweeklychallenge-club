#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 305 Task 2 Alien Dictionary
#=============================================================================
# You are given a list of words and alien dictionary character order.
# Write a script to sort lexicographically the given list of words based
# on the alien dictionary characters.
# Example 1 Input: @words = ("perl", "python", "raku")
#                  @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
#           Output: ("raku", "python", "perl")
#
# Example 2 Input: @words = ("the", "weekly", "challenge")
#                  @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
#           Output: ("challenge", "the", "weekly")
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my @Dictionary = ('a' .. 'z');
my $D;

GetOptions("dictionary:s" => \$D, "test" => \$DoTest,
            "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

if ( $D )
{
    @Dictionary = split(//, $D);
}

say '("', join('", "', alien(\@Dictionary, @ARGV)->@*), '")';

#=============================================================================
sub alien($dictionary, @words)
{
    state $ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWZYZabcdefghijklmnopqrstuvwxyz';

    my $d = join("", @$dictionary);
    $d = uc($d) . lc($d);

    my %translated;
    for my $w ( @words )
    {
        eval "\$translated{$w} = ((fc \$w) =~ tr/$ALPHABET/$d/r)";
        die $@ if $@;
    }
    return [ sort { $translated{$a} cmp $translated{$b} } @words ];
}

sub runTest
{
    use Test2::V0;

    is( alien( [ qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/ ],
               qw/perl python raku/), [ qw/raku python perl/ ], "Example 1");

    is( alien( [ qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/ ],
               qw/the weekly challenge/), [ qw/challenge the weekly/ ], "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
