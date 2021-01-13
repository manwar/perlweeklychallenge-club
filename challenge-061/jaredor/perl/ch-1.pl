#!/usr/bin/env perl

use v5.012;
use warnings;
use integer;
use Getopt::Long;
use Pod::Usage;
use List::Util qw(product all);
use Scalar::Util qw(looks_like_number);

# PWC 061, TASK #1 : Product SubArray

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'help|h!' => \( my $help ),
    'task|t!' => \( my $task ),
    'test'    => \( my $test )
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

if ($test) {

    test();

}
else {

    # Use side-effect of modifying element in grep to remove "," & "[" & "]".

    my @intargs = grep { tr/][, //d; s/\A 0+ \B//xms; /\S/ } @ARGV;

    # Bundle up fatal input errors to report them all at once.

    my @errors;
    push @errors, "Four or more integers needed"
      unless 4 <= @intargs;
    push @errors, "Some arguments do not look numeric"
      unless all { looks_like_number $_ } @intargs;
    push @errors, "Some arguments are not integers"
      unless all { /\A [+-]? \d+ \Z/xms } @intargs;
    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results(@intargs);
}

exit;    # End of main script.

# The main algorithm.

sub get_maximal_product_sublists {

    return ( undef, [] ) unless @_ >= 4;

    my @list_of_ints = @_;
    my ( $prev_prod, @prev, @curr, @hold ) = ( 0, );

    for my $intarg ( ( @list_of_ints, 0 ) ) {
        if ( $intarg <= 0 ) {
            if ( $intarg < 0 ) {
                if (@hold) {
                    @curr = ( @hold, @curr, $intarg );
                    undef @hold;
                }
                else {
                    @hold = ( @curr, $intarg );
                    undef @curr;
                }
            }
            else {
                pop @hold;    # Remove neg val
                for my $sublist ( \@hold, \@curr ) {
                    my $sublist_prod = product @$sublist;
                    if ( @$sublist and $sublist_prod >= $prev_prod ) {
                        @prev = () if $sublist_prod > $prev_prod;
                        push @prev, [@$sublist];
                        $prev_prod = $sublist_prod;
                    }
                }
                undef @hold;
                undef @curr;
            }
        }
        else {
            push @curr, $intarg;
        }
    }

    ( $prev_prod, @prev ) = ( 0, ( [@list_of_ints], ) ) unless @prev;

    return ( $prev_prod, [@prev] );
}

# Report to STDOUT from user command line input.

sub output_results {

    my ( $max_prod, $max_sublists ) = get_maximal_product_sublists @_;
    my @max_sublists = @$max_sublists;

    my $s = @max_sublists > 1 ? 's' : '';

    say "\nMaximum product: $max_prod";

    say "Maximal contiguous sublist$s with product:";

    while (@max_sublists) {
        my $sublist = shift @max_sublists;
        say "\t[ ", join( ', ', @$sublist ), " ]";
    }
}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my @input;

    @input = 1 .. 4;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 24, [ [@input] ] ],
        'Basic start'
    );

    @input = (0) x 4;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 0, [ [@input] ] ],
        'Four Zeroes'
    );

    @input = qw(2 5 -1 3);
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 10, [ [ 2, 5 ] ] ],
        'Task Example'
    );

    @input = qw(-1 0 -2 0 -3 0 -4 0 -5);
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 0, [ [@input] ] ],
        'No positive products'
    );
    @input = qw(1 -1 0 -2 0 -3 0 -4 0 -5);
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 1, [ [1] ] ],
        'Leading 1, otherwise no positive prodcuts'
    );
    @input = qw(-1 -1 0 -2 0 -3 0 -4 0 -5);
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 1, [ [ -1, -1 ] ] ],
        'Leading -1, first two terms are -1'
    );

    # The next 4 tests cumulatively modify the @input array.

    @input = 1 .. 10;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 3628800, [ [@input] ] ],
        'Ten factorial'
    );

    $input[3] *= -1;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 151200, [ [ @input[ 4 .. 9 ] ] ] ],
        'Ten factorial with a -4 factor instead of +4'
    );

    $input[6] *= -1;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 3628800, [ [@input] ] ],
        'Ten factorial with a -4 & -7 factors instead of +4 & +7'
    );

    $input[8] *= -1;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 40320, [ [ @input[ 0 .. 7 ] ] ] ],
        'Ten factorial with a -4 & -7 & -9 factors instead of +4 & +7 & +9'
    );

    # The next two tests demonstrate the illustration at the end of the
    # INTERPRETATION section in the task.

    @input = qw(2 -1 -1 0 1 0);
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 2, [ [ @input[ 0 .. 2 ] ] ] ],
        'The [ 2, -1, -1 ] example from INTERPRETATION.'
    );

    push @input, 2;
    is_deeply(
        [ get_maximal_product_sublists @input ],
        [ 2, [ [ @input[ 0 .. 2 ] ], [ $input[-1] ] ] ],
        'The [ 2, -1, -1 ] & [ 2 ] example from INTERPRETATION.'
    );

    done_testing();
}

__END__

=head1 NAME

PWC 061, TASK #1 : Product SubArray

=head1 SYNOPSIS

  ch-1.pl [options] integer1 integer2 integer3 integer4 [integer5 ... integerN]

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    Four or more integers must be supplied as input arguments.

=head1 OPTIONS

=over 8

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=item B<--test>

Run the embedded test suite for this script.

=back

=head1 DESCRIPTION

Given a list of 4 or more numbers, write a script to find the contiguous sublist
that has the maximum product. The length of the sublist is irrelevant; your job
is to maximize the product.

=head2 Example

=head3 Input:

  [ 2, 5, -1, 3 ]

=head3 Output:

  [ 2, 5 ] which gives maximum product 10.

=head1 INTERPRETATION

The problem says "4 or more numbers" but the example shows integers, so I
decided that "number" meant "integer" in this case. Things would be more
complicated (I think) if the problem allowed floating point, so I interpreted
"number" as "integer".

The Input and Output in the example was a mix of notation for a perl array and
text, so I split the difference and allowed for anything that looked like the
task input on the command line, but it really just needs numeric arguments and
the command and brackets are just stripped out of the input.

There can be more than one sub-list that produces a maximum product, so instead
of producing all sublists, only the maximal sublists are given. This effectively
means that padding with 1 and -1 are included in a sublist, e.g., both [ 2 ] and
[2, -1, -1] have a product of 2, but for the run of numbers, [2, -1, -1], only
the [2, -1, -1] sublist will be listed because the [ 2 ] list is a sublist
contained within. If [ 2 ] appears as a sublist somewhere else, it will be
listed if it is maximal. For example, with the list of integers
[ 2, -1, -1, 0, 1, 0 ] there is only one maximal sublist, [ 2, -1, -1 ], but for
the list [ 2, -1, -1, 0, 1, 0, 2 ] there are two maximal sublists [ 2, -1, -1 ]
and [ 2 ], the [ 2 ] list being the maximal sublist at the very end of the input
list.

=cut
