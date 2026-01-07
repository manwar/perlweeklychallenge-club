#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 355 Task 1 Thousands Separator
#=============================================================================
# You are given a positive integer, $int.  Write a script to add thousand
# separator, and return as string.
# Example 1 Input: $int = 123 Output: "123"
# Example 2 Input: $int = 1234 Output: "1,234"
# Example 3 Input: $int = 1000000 Output: "1,000,000"
# Example 4 Input: $int = 1 Output: "1"
# Example 5 Input: $int = 12345 Output: "12,345"
#=============================================================================
# Benchmark sample:
#                 Rate  withregex  asinteger withsubstr joinunpack
# withregex   606061/s         --       -16%       -52%       -64%
# asinteger   724638/s        20%         --       -42%       -57%
# withsubstr 1250000/s       106%        72%         --       -25%
# joinunpack 1666667/s       175%       130%        33%         --
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

my @example = (
    {   id => "Example 1", int =>     123, expect =>       "123" },
    {   id => "Example 2", int =>    1234, expect =>     "1,234" },
    {   id => "Example 3", int => 1000000, expect => "1,000,000" },
    {   id => "Example 4", int =>       1, expect =>         "1" },
    {   id => "Example 5", int =>   12345, expect =>    "12,345" },
);

my @task = (
    { tag => "regex",   func => \&separate },
    { tag => "integer", func => \&sepint },
    { tag => "substr",  func => \&sepstr },
    { tag => "unpack",  func => \&sepjoin },
    { tag => 'format',  func => \&sepformat },
);

#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

for my $n (@ARGV)
{
    foreach ( @task )
    {
        say "$_->{tag}: ", $_->{func}->($n);
    }
}

#=============================================================================
sub sepformat($int)
{
    use Number::Format qw/:subs/;
    return format_number($int);
}

sub separate($int)
{
    scalar reverse ( (reverse $int) =~ s/(\d{3})(?=\d)/$1,/gr );
}

sub sepint($int)
{
    my $sep = sprintf("%03d", $int % 1000);
    while ( $int = int($int / 1000) )
    {
        $sep = sprintf("%03d,$sep", ($int % 1000));
    }
    return ($sep =~ s/^0+//r);
}

sub sepstr($int)
{
    my $sep = substr($int, -3, 3, "");
    while ( (my $three = substr($int, -3, 3, "")) ne "" )
    {
        $sep = "$three,$sep";
    }
    return $sep;
}

sub sepjoin($int)
{
    return scalar reverse join(",", unpack("(A3)*", reverse $int));
}

sub runTest
{
    use Test2::V0;

    for my $task ( @task )
    {
        for ( @example )
        {
            is( $task->{func}->($_->{int}), $_->{expect}, "$_->{id} $task->{tag}");
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $n = 12345678901234;

    cmpthese($repeat, {
            withregex  => sub { separate($n) },
            asinteger  => sub { sepint($n) },
            withsubstr => sub { sepstr($n) },
            joinunpack => sub { sepjoin($n) },
            format     => sub { sepformat($n) },
        });
}
