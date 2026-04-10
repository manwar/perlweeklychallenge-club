#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 171 Task 2  First Class Function
#=============================================================================
# Create sub compose($f, $g) which takes in two parameters $f and $g as
# subroutine refs and returns subroutine ref i.e.
# compose($f, $g)->($x) = $f->($g->($x))
#   e.g.  $f = (one or more parameters function)
#         $g = (one or more parameters function)
#   $h = compose($f, $g)
#   $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

sub f($x) { $x + 7 }
sub g($x) { $x * 2 }

my $h = compose( \&f, \&g );
say $h->($_);

#=============================================================================
sub compose($f, $g )
{
    return sub { $f->( $g->(@_) ) };
}

sub runTest
{
    use Test2::V0;

    sub f1($x) { $x + 7 }
    sub g1($x) { $x * 2 }
    my $h = compose( \&f1, \&g1 );

    is( $h->(3), 13, "h(3) = f( g(3) )");

    $h = compose( sub { $_[0] * 2 }, sub { $_[0] + 5 } );
    is( $h->(3), 16, , "h(3) = *2(+5)");

    done_testing;
}
