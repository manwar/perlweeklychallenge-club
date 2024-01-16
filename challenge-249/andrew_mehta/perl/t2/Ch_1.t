
# Custom Libraries:
use Path::Tiny;
use lib path(__FILE__)->parent->parent->realpath->stringify;
use lib path(__FILE__)->parent->sibling('lib')->realpath->stringify;

# Standard Test Boilerplate:
use TestBoilerplate;

# Specific Modules used:
use Ch_1;

=pod Name, Version, Synopsis, Description

=encoding utf8

=head1 NAME

Ch_1.t Test File.

=head1 VERSION

v1.0.0

=cut

our $VERSION                    =   'v1.0.0';

=head1 SYNOPSIS

    yath -v # Will automatically run tests found in the ./t2 folder ( such as this test ), in verbose mode.

=head1 DESCRIPTION

This unit test, tests the C<Ch_1.pm> Perl modulino,
originally made for the Perl Weekly Challenge 249
Task 1 (set 25th December 2023).

It tests for the C<Ch_1> class
and that class' C<answer> and C<answer_data> methods;
then tests the output of these methods,
given a variety of input test data
and output expectations.

For each piece of provided test data,
this unit test
checks for errors,
and if the script dies or lives;
and then checks for output,
and if output is as expected.
Finally it checks that
the challenge rules have been met:

=over

=item 1

Each element belongs to exactly one pair.

=item 2

The elements present in a pair are equal.

=back

Both Input Data and Output Expectations
are set in a single array
within the source code
of this unit test script.

=cut

# Initial Values:
my  $text = {
    prefix                      =>  '[Test Case %04d] - %s - %s.',
    result_prefix               =>  "Here are your equal pairs:\nOutput: ",
    no_pairs_result             =>  'No equal pairs found',
    true                        =>  'Output is true',
    'dies'                      =>  'Programme died',
    delivers_result             =>  'Programme delivered result and did not die',
    error                       =>  'Error(s) found',
    no_error                    =>  'No Error(s) found',
    address_errors              =>  'address these errors',
    expected                    =>  'Contained expected output - "%s"',
    class                       =>  'Class Name As Expected',
    methods                     =>  'Expected Methods Present',
    two                         =>  'Pair %d consists of two values: (%d,%d)',
    frequency                   =>  'Each input element of "%d" that became paired (%d out of %d) belongs to exactly one pair',
    equal                       =>  'Pair %d elements are equal: (%d,%d)',
};
my  $error = {
    uneven                      =>  '[1] - Expected an even number of elements',
    non_integer                 =>  '[1] - Expected input array reference to contain only integer digits',
    empty                       =>  '[1] - Input array reference was found to be empty',
    die_message                 =>  'Exiting due to',
};
my  $value_delimiter            =   ", ";
my  $matches_die_message        =   qr/\Q$error->{'die_message'}/;
my  $matches_error              =   qr/\Q$text->{'address_errors'}/;
my  $matches_result             =   qr/(
                                        \Q$text->{'result_prefix'}\E
                                        |
                                        \Q$text->{'no_pairs_result'}\E
                                    )/x;
my  $test_name                  =   sub { sprintf($text->{prefix}, @ARG) };
my  $test_count                 =   1;
my  $expected_class             =  'Ch_1';
my  @expected_methods           =  qw(answer answer_data);

# Test Data:
my  @test_data = (
    # Test Name                     # Input:                        #Expected Output
    'Odd Number of Elements'    =>  [qw(1 2 3)]                 =>  $error->{'uneven'},
    'Letter Elements'           =>  [qw(a a a b b b)]           =>  $error->{'non_integer'},
    'Digits and Letters'        =>  [qw(1 a 1 b 1 b)]           =>  $error->{'non_integer'},
    'Words'                     =>  [qw(cat sat mat different)] =>  $error->{'non_integer'},
    'No Equal Integer Pairs'    =>  [qw(1 2 3 4)]               =>  $text->{'no_pairs_result'},
    'No Elements'               =>  [qw()]                      =>  $error->{'empty'},
    'One Large Digit'           =>  [qw(999999999)]             =>  $error->{'uneven'},
    'Lots Of Large Digits 1'    =>  [qw(
                                        112 16648 19999
                                        9999999 9999999
                                        112 88888888888
                                        88888888888 112
                                        19999
                                    )]                          =>  'Output: (112,112),(19999,19999),(9999999,9999999),(88888888888,88888888888)',
    'Lots Of Large Digits 2'    =>  [qw(
                                        112 16648 19999
                                        9999999 9999999
                                        112 88888888888
                                        88888888888 112
                                        19999 233333556
                                    )]                          =>  $error->{'uneven'},
    'End Odd List With Undef'   =>  [qw(
                                        112 16648 19999
                                        9999999 9999999
                                        112 88888888888
                                        88888888888 112
                                        19999
                                    ),undef]                    =>  'Output: (112,112),(19999,19999),(9999999,9999999),(88888888888,88888888888)',
    'End Even List With Undef'  =>  [qw(
                                        112 16648 19999
                                        9999999 9999999
                                        112 88888888888
                                        88888888888 112
                                        19999 233333556
                                    ),undef]                    =>  $error->{'uneven'},
    'Odd List With '.
    'Undef In Middle'           =>  [qw(
                                        112 16648 19999
                                        9999999 9999999
                                        112), undef, qw(
                                        88888888888
                                        88888888888 112
                                        19999
                                    )]                          =>  'Output: (112,112),(19999,19999),(9999999,9999999),(88888888888,88888888888)',
    'Even List '.
    'With Undef In Middle'      =>  [qw(
                                        112 16648 19999
                                        9999999 9999999
                                        112), undef, qw(
                                        88888888888
                                        88888888888 112
                                        19999 233333556
                                    )]                          =>  $error->{'uneven'},
    'Four Byte Unicode 1'       =>  [qw(🃑 🃑)]                   => $error->{'non_integer'},
    'Four Byte Unicode 2'       =>  [qw(🃑 1)]                   => $error->{'non_integer'},
    'Four Byte Unicode 3'       =>  [qw(🃑 🃑 1 1)]               => $error->{'non_integer'},
    'Odd List With '.
    'All Elements Undef'        =>  [undef,undef,undef]         =>  $error->{'empty'},
    'Even List With '.
    'All Elements Undef'        =>  [undef,undef,undef,undef]   =>  $error->{'empty'},
    'Single Digits Test 1'      =>  [qw( 1 2 3 4 4 4 5 6 )]     =>  'Output: (4,4)',
    'Single Digits Test 2'      =>  [qw( 1 2 3 4 4 4 5 6 5 6 )] =>  'Output: (4,4),(5,5),(6,6)',
    'Non-single Digits Test 1'  =>  [qw(
                                        01 02 33 44 44 44
                                        5555 66 5555 66 01 01
                                    )]                          =>  'Output: (01,01),(44,44),(66,66),(5555,5555)',
    'Many Similar Numbers 1'    =>  [qw(
                                        1 1 1 1 1 1 1 1
                                        23 23 23 23 23
                                        2023 2023 2023
                                        400000 400000
                                        400000 400000
                                        400000 400000
                                        9999999999999
                                        9999999999999
                                    )]                          =>  'Output: (1,1),(1,1),(1,1),(1,1),'.
                                                                    '(23,23),(23,23),(2023,2023),'.
                                                                    '(400000,400000),(400000,400000),(400000,400000),'.
                                                                    '(9999999999999,9999999999999)',
    'Nonsense'                  =>  [qw( gfhdsjsahsgshhjsh )]   =>  $text->{'address_errors'},
);

# Test Processing:

isa_ok(
    Ch_1                        =>  [$expected_class],
    $test_name->($test_count++, $text->{'class'}, $expected_class)
);

can_ok(
    Ch_1                        =>  [@expected_methods],
    $test_name->($test_count++, $text->{'methods'}, join($value_delimiter, @expected_methods))
);

# Test Data Processing:

for my ($name, $input, $expected_string) (@test_data) {

    my  $matches_expected       =   qr/\Q$expected_string/;
    my  $output                 =   combined_from(
                                        sub {
                                            my      $successful_output   =   undef;
                                            warn    $successful_output
                                                    if
                                                        lives { $successful_output = Ch_1->answer($input->@*) }
                                                        && defined $successful_output;
                                        }
                                    );
    my  $delivers_result        =   0;

    if ($EVAL_ERROR) {
        like(
            $output             =>  $matches_error,
            $test_name->($test_count++, $name, $text->{'error'})
        );

        like(
            $EVAL_ERROR         =>  $matches_die_message,
            $test_name->($test_count++, $name, $text->{'dies'})
        );
    }
    else {
        unlike(
            $output             =>  $matches_error, #unlike
            $test_name->($test_count++, $name, $text->{'no_error'}) #unlike
        );
        $delivers_result =
        like(
            $output             =>  $matches_result,
            $test_name->($test_count++, $name, $text->{'delivers_result'})
        );
    };

    is(
        $output                 =>  T(),
        $test_name->($test_count++, $name, $text->{'true'})
    );

    like(
        $output                 =>  $matches_expected,
        $test_name->($test_count++, $name, sprintf($text->{'expected'}, $expected_string))
    );

    # Test Challenge Rules:
    if ($delivers_result) {

        # Initial Values:
        my  @output_data                =   Ch_1->answer_data($input->@*);

        if (@output_data) {

            # Initial Values:
            my  %input_frequency        =   ();
            my  %output_frequency       =   ();
            my  @flattened_output_data  =   ();
            push @flattened_output_data ,   $ARG->@* for @output_data;
            my  $pair_count             =   1;

            # Process Frequencies:
            $input_frequency{$ARG}++        for map {defined $ARG? $ARG:()} $input->@*;
            $output_frequency{$ARG}++       for map {defined $ARG? $ARG:()} @flattened_output_data;

            # Test Processing:

            # a) Each element belongs to exactly one pair.
            for my $input_item (sort {$a <=> $b} keys %input_frequency) {
                exists $output_frequency{$input_item}
                && ok(
                    $output_frequency{$input_item} <= $input_frequency{$input_item} <= $output_frequency{$input_item} + 1,
                    $test_name->($test_count++, $name, sprintf($text->{'frequency'}, $input_item, $output_frequency{$input_item}, $input_frequency{$input_item})),
                );
            };

            # b) The elements present in a pair are equal.
            for my $pair (@output_data) {
                is(
                    scalar $pair->@*    =>  2,
                    $test_name->($test_count++, $name, sprintf($text->{'two'}, $pair_count, $pair->@*)),
                )
                && is(
                    $pair->[0]          =>  $pair->[1],
                    $test_name->($test_count++, $name, sprintf($text->{'equal'}, $pair_count++, $pair->@*)),
                );
            };

        };

    };

}

done_testing();

=head1 AUTHOR

Andrew Mehta

=cut

__END__
