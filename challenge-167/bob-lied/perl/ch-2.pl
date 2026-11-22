#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 167 Task 2  Gamma Function
#=============================================================================
# Implement subroutine gamma() using the Lanczos approximation method.
# https://en.wikipedia.org/wiki/Lanczos_approximation
# [2022-05-31] Ryan Thompson wrote an interesting blog explaining the
# subject in details. Highly recommended if you are looking for more information.
# https://ry.ca/2022/05/lanczos-approximation
# Example
#   gamma(3); # 1.99
#   gamma(5); # 24
#   gamma(7); # 719.99
#=============================================================================

use v5.44;
use utf8;


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

exit(!runTest()) if $DoTest;

say Γ($_) for @ARGV;

#=============================================================================
sub Γ($z)
{
    use constant π => 4 * atan2(1,1);

    die "Negative argument to Γ()" if $z < 0;

    # Magic coefficients from Wikipedia article
    use constant  g => 7;
    use constant p0 => 0.99999999999980993;
    state @p  = (    676.5203681218851,
                   -1259.1392167224028,
                     771.32342877765313,
                    -176.61502916214059,
                      12.507343278686905,
                      -0.13857109526572012,
                       0.0000099843695780195716,
                       0.00000015056327351493116,
    );

    if ( $z < 0.5 )
    {
        return π / ( sin( π * $z ) * Γ( 1 - $z ) );
    }

    my $x = p0;
    for my ($i, $p) ( indexed @p )
    {
        $x += $p / ( $z + $i );
    }

    my $t = $z + g - 0.5;
    return sqrt(2*π) * ( $t**( $z - 0.5 ) ) * exp(-$t) * $x;
}

sub runTest
{
    use Test2::V1 -ipP;

    my $tolerance = 10e-8;

    ok( abs( Γ(3) -   2.00 ) < $tolerance, "Γ(3)");
    ok( abs( Γ(5) -  24.00 ) < $tolerance, "Γ(5)");
    ok( abs( Γ(7) - 720.00 ) < $tolerance, "Γ(7)");

    ok( abs( Γ(0.4) - 2.2181595 ) < $tolerance, "Γ(0.4)");
    ok( abs( Γ(0.5) - 1.7724538 ) < $tolerance, "Γ(0.5)");
    ok( abs( Γ(3.5) - 3.3233509 ) < $tolerance, "Γ(3.5)");

    done_testing;
}
