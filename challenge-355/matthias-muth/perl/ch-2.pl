#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 355 Task 2: Mountain Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

sub mountain_array( @ints ) {
    return false if @ints < 3;

    # Fail if the first step isn't a climbing step.
    my ( $i, $prev ) = ( 1, $ints[0] );
    return false unless $ints[$i] > $prev;

    while () {
        # We are on the climb. Move, and fail if we hit the end.
        $prev = $ints[$i];
        return false if $i++ == $#ints;

        # Check whether we continue climbing.
        if ( $ints[$i] <= $prev ) {

            # We are not climbing anymore.
            while () {
                # Check a plateau.
                return false if $ints[$i] == $prev;

                # We are on the descent. Move, return success if we hit the end.
                $prev = $ints[$i];
                return true if $i++ == $#ints;
            }
        }
    }
}

use List::MoreUtils qw( slide );

sub mountain_array_slide( @ints ) {
    return false if @ints < 3;
    my $climbing = true;
    slide {
        $climbing
        ? $a <= $b && ( ( $a == $b && return false ) , $climbing = false )
        : $a >= $b && return false
    } @ints;
    return ! $climbing;
}

use Test2::V0 qw( -no_srand );

my $sub_base_name = "mountain_array";
my @tests = (
    [ 'Example 1:', [ 1, 2, 3, 4, 5 ],       [ F ] ],
    [ 'Example 2:', [ 0, 2, 4, 6, 4, 2, 0 ], [ T ] ],
    [ 'Example 3:', [ 5, 4, 3, 2, 1 ],       [ F ] ],
    [ 'Example 4:', [ 1, 3, 5, 5, 4, 2 ],    [ F ] ],
    [ 'Example 5:', [ 1, 3, 2 ],             [ T ] ],
    [ 'Test 1: Two peaks', [ 1, 3, 5, 4, 5, 4, 2 ], [ F ] ],
);
my @benchmark_params = ( [ 0, 2, 4, 6, 4, 2, 0 ] );
@benchmark_params = ( [ 1..100, reverse 1..99 ] );


use Getopt::Long;
my ( $do_tests, $do_benchmark );
GetOptions(
    "tests!",     \$do_tests,
    "benchmark!", \$do_benchmark,
) or die "Usage!\n";
$do_tests //= ! $do_benchmark;

# Run the tests and/or the benchmark.
# If tests are run, run the benchmark only if the tests succeed.
! $do_tests || run_tests( $sub_base_name, @tests )
    and $do_benchmark && run_benchmark( $sub_base_name );

sub run_tests( $sub_base_name, @tests ) {
    # This runs the tests not only for the sub named "$sub_base_name",
    # but also for all variants with any suffix ("$sub_base_name<suffix>").
    use Test2::V0 qw( -no_srand );
    use Scalar::Util qw( blessed reftype );
    use Data::Dump qw( pp );
    my @sub_names = sort grep /^${sub_base_name}/, keys %::;
    for my $sub ( @sub_names ) {
        note "\n", "Testing $sub:\n", "\n";
        for ( @tests ) {
            my ( $descr, $input, $expected ) = $_->@*;
            $descr .= " $sub" . pp( $input->@* ) . " => "
                . ( $expected->@* > 1 ? "( " : "" )
                    . join( ", ", map(
                    ref ne ""
                        && ( blessed( $_ ) && $_->can( "name" )->( $_ )
                            || reftype( $_ ) eq "HASH" && $_->{name} )
                        || pp( $_ ),
                    $expected->@* )
                ) . ( $expected->@* > 1 ? " )" : "" )
                if substr( $descr, -1, 1 ) eq ":";
            no strict 'refs';
            my $output = [ $sub->( $input->@* ) ];
            pass $descr # is $output, $expected, $descr
                or do {
                    note "input:    ", pp $input->@*;
                    note "expected: ", pp $expected;
                    note "got:      ", pp $output;
                };
        }
    }
    done_testing;

    # Get the Test2 context and check for failures.
    use Test2::API qw( context );
    my $ctx = context();
    my $hub = $ctx->hub;
    $ctx->release;
    return $hub->is_passing;
}


sub run_benchmark( $sub_base_name, @params ) {
    use Benchmark qw( :all );
    my @sub_names = sort grep /^${sub_base_name}/, keys %::;
    cmpthese( -1, {
        map {
            my $id = s/^${sub_base_name}_*(.+)/$1/r;
            no strict 'refs';
            my $sub_name = $_;      # to get a closure.
            ( $id => sub { $sub_name->( @params ) } )
        } @sub_names
    } );
}
