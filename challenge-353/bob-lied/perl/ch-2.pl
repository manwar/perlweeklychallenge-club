#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 353 Task 2  Validate Coupon
#=============================================================================
# You are given three arrays, @codes, @names and @status.
# Write a script to validate codes in the given array.
# A code is valid when the following conditions are true:
#   - codes[i] is non-empty and consists only of alphanumeric characters
#     (a-z, A-Z, 0-9) and underscores (_).
#   - names[i] is one of the following four categories: "electronics",
#     "grocery", "pharmacy", "restaurant".
#   - status[i] is true.
#
# Return an array of booleans indicating validity: output[i] is true if and
# only if codes[i], names[i] and status[i] are all valid.
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
my @case = (
    { id     => 'Example 1',
      codes  => [ 'A123',        'B_456',      'C789',        'D@1',      'E123' ],
      names  => [ 'electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery' ],
      status => [ 'true',        'false',      'true',        'true',     'true' ],
      expect => [ true, false, true, false, true ],
    },
    { id     => 'Example 2',
      codes  => [ 'Z_9',      'AB_12',       'G01',     'X99',         'test' ],
      names  => [ 'pharmacy', 'electronics', 'grocery', 'electronics', 'unknown' ],
      status => [ 'true',     'true',        'false',   'true',        'true' ],
      expect => [ true, true, false, true, false ],
    },
    { id     => 'Example 3',
      codes  => [ '_123',       '123',         '',            'Coupon_A', 'Alpha' ],
      names  => [ 'restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery' ],
      status => [ 'true',       'true',        'false',       'true',     'true' ],
      expect => [ true, true, false, true, true ],
    },
    { id     => 'Example 4',
      codes  => [ 'ITEM_1',      'ITEM_2',      'ITEM_3',  'ITEM_4' ],
      names  => [ 'electronics', 'electronics', 'grocery', 'grocery' ],
      status => [ 'true',        'true',        'true',    'true' ],
      expect => [ true, true, true, true ],
    },
    { id     => 'Example 5',
      codes  => [ 'CAFE_X',     'ELEC_100',    'FOOD_1',  'DRUG_A',   'ELEC_99' ],
      names  => [ 'restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics' ],
      status => [ 'true',       'true',        'true',    'true',     'false' ],
      expect => [ true, true, true, true, false ],
    },
);
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my $answer = valid( [$ARGV[0]], [$ARGV[1]], [$ARGV[2]] );
say '(', join(", ", map { $_ ? "true" : "false" } $answer->@*), ')';

#=============================================================================
sub valid($code, $name, $status)
{
    state %ValidName = ( electronics => true, grocery => true,
                         pharmacy => true, restaurant => true );
    my @valid = (true) x $code->@*;

    for my ($i, $c) ( indexed $code->@* )
    {
        $valid[$i] &&= ( $code->[$i] !~ m/[^a-zA-Z0-9_]/ );
        $valid[$i] &&= ( exists $ValidName{$name->[$i]} );
        $valid[$i] &&= $status->[$i] eq "true";
    }
    return \@valid;
}

sub validEach($code, $name, $status)
{
    state %ValidName = ( electronics => true, grocery => true,
                         pharmacy => true, restaurant => true );
    
    my @valid;

    use List::MoreUtils qw/each_arrayref/;
    my $ea = each_arrayref($code, $name, $status);
    while ( my ($c, $n, $s) = $ea->() )
    {
        push @valid, ( $c =~ m/^[a-zA-Z0-9_]+$/ )
                  && ( exists $ValidName{$n}    )
                  && ( $s eq "true"             );
    }
    return \@valid;
}

sub runTest
{
    use Test2::V0;

    for ( @case )
    {
        is( valid($_->{codes}, $_->{names}, $_->{status}), $_->{expect}, $_->{id} );
    }

    for ( @case )
    {
        is( validEach($_->{codes}, $_->{names}, $_->{status}), $_->{expect}, $_->{id} );
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            forindex => sub {
                for ( @case )
                {
                    valid($_->{codes}, $_->{names}, $_->{status});
                }
            },
            iterator => sub {
                for ( @case )
                {
                    validEach($_->{codes}, $_->{names}, $_->{status});
                }
            },
        });
}
