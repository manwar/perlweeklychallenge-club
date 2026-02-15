#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       MultiTest.pm - run tests and/or a benchmark
#                      for multiple implementations
#

use v5.36;

package MultiTest;
use parent 'Exporter';
our @EXPORT    = qw( run run_tests );
our @EXPORT_OK = qw( run_benchmarks );

# Accept --tests and --benchmark command line options
# (which can be abbreviated to -t and -b, respectively).
# The default is to run tests only (equivalent to --tests --nobenchmark).
# If --benchmark is given, --tests has to be given explicitly if you also
# want to run tests. In that case, the tests will be run first, and the
# benchmark will only be run if the tests succeed.
# TODO: Write some pod for usage.
my ( $do_tests, $do_benchmark );
use Getopt::Long qw( :config pass_through auto_abbrev );
GetOptions(
    "benchmark!", \$do_benchmark,
    "tests!",     \$do_tests,
) or die "Usage!\n!";
$do_tests //= ! $do_benchmark;
Getopt::Long::Configure( "default" );

sub run( $sub_base_name, $tests, $benchmark_params = undef ) {
    # Run the tests and/or the benchmark, depending on the command line options.
    # If tests are run, run the benchmark only if the tests succeed.
    ! $do_tests || run_tests( $sub_base_name, $tests->@* )
        and $do_benchmark && run_benchmark( $sub_base_name, $benchmark_params );
}

sub run_tests( $sub_base_name, @tests ) {
    # This runs the tests not only for the sub named "$sub_base_name",
    # but also for all variants with any suffix ("$sub_base_name<suffix>").
    use Test2::V0 qw( -no_srand );

    use constant HAS_DATA_DUMP =>
        defined eval { require XData::Dump and Data::Dump->import( 'pp' ); 1 };
    note "\n",
        "Please install Data::Dump from CPAN for nicer test result output.",
        "\n"
        unless HAS_DATA_DUMP;

    use constant HAS_TABLE_TERM_UTIL =>
        defined eval {
            require Term::Table::Util
                and Term::Table::Util->import( 'term_size' );
            1;
        };

    # Avoid messages about table width in case of test failures.
    my $term_size = $ENV{TABLE_TERM_SIZE}
        //= HAS_TABLE_TERM_UTIL ? term_size() : 80;

    my @sub_names = sort grep /^${sub_base_name}/, keys %::;
    for my $sub ( @sub_names ) {
        note "\n", "Testing $sub:\n", "\n";
        for ( @tests ) {
            my ( $test, $input, $expected ) = $_->@*;
            my $descr = $test;
            if ( HAS_DATA_DUMP ) {
                $descr .= " $sub"
                    . "( " . ( pp( $input->@* ) =~ s/^\((.*?)\)$/$1/r ) . " )"
                    . "\n    "
                    . "=> " . pp( $expected->@* )
                    if HAS_DATA_DUMP && substr( $descr, -1, 1 ) eq ":";
                $descr =~ s/\n   (?= =>)//
                    if length( $descr ) - length( "\n   " ) <= $term_size - 8;
            }
            else {
                $descr =~ s/:$//;
            }
            no strict 'refs';
            my $output = [ "::$sub"->( $input->@* ) ];
            is $output, $expected, $descr
                or HAS_DATA_DUMP && do {
                    note "input:    ", pp( $input->@* );
                    note "expected: ", pp( $expected );
                    note "got:      ", pp( $output );
                };
        }
    }
    done_testing;

    # Get the Test2 context and check for failures.
    my $ctx = context();
    my $hub = $ctx->hub;
    $ctx->release;
    return $hub->is_passing;
}

sub run_benchmark( $sub_base_name, $benchmark_params ) {
    use Benchmark qw( cmpthese );
    my @sub_names = sort grep /^${sub_base_name}/, keys %::;
    my %subs = map {
        my $id = s/^${sub_base_name}_*(.+)/$1/r;
        my $sub_name = $_;      # to get a closure.
        no strict 'refs';
        ( $id => sub { "::$sub_name"->( $benchmark_params->@* ) } )
    } @sub_names;
    cmpthese( -1, \%subs );
}

1;
