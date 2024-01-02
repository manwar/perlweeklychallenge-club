use     Object::Pad 0.807;
use     strict;
use     warnings;

package EqualPairs v1.0.0;
class   EqualPairs {

    use File::Basename;
    use lib dirname(__FILE__)."/lib";
    use CodeBoilerplate;
    use Data::Dumper qw(Dumper); # Used in input validation check warnings.
    use Pod::Text::Color;

=pod Name, Synopsis, Description

=encoding utf8

=head1 NAME

EqualPairs - Additional Class / Package within Ch_1.pm file.

=cut

=head1 SYNOPSIS

    my  @input              =   (3, 2, 3, 2, 2, 2);
    my  $answer_to_task_1   =   EqualPairs->new->input(@input)->pretty_output;

=cut

=head1 DESCRIPTION

For the construction of new EqualPairs object instances,
used in providing the answer
to the Perl Weekly Challenge 249
Task 1 (set 25th December 2023).

Package omits...

    1;

...at the end, as this is not needed
with feature bundles v5.37 or higher,
as documented at
L<https://perldoc.perl.org/functions/require>.

=cut

=head1 METHODS

=over

=item new(input => $array_reference);

    # With default empty input:
    my  $equal_pairs_object =   EqualPairs->new;

    # With input provided as array reference:
    my  $array_reference    =   [3, 2, 3, 2, 2, 2];
    my  $equal_pairs_object =   EqualPairs->new(input => $array_reference);

Constructs and returns a new object instance.
Optionally, the constructor
can set the input object attribute.

=cut

    field   $input  :param          =   [];

=item output;

    my  @empty_array                =   EqualPairs->new->output;
    my  @array_of_array_references  =   EqualPairs->new->input(3, 2, 3, 2, 2, 2)->output;

Returns an array, containing an array reference
for each equal pair found during input processing.

If no pairs of equal numbers are found,
or no input has been set yet,
will return an empty array.

=cut

    field   @output :reader         =   ();

    my      $new_line               =   "\n";
    my      $line_reference_prefix  =   'Reported';

    method  $filter_input {

        # Initial Values:
        my  $filtered               =   [];
        my  $changes                =   0;
        my  $array_reference        =   $input
                                        && (
                                            (ref $input) eq 'ARRAY'
                                        );

        # Filter Out Undef:
        push $filtered->@*          ,   map {
                                            if (defined $ARG) {
                                                $ARG;
                                            }
                                            else {
                                                $changes++;
                                                ();
                                            };
                                        } $input->@*
                                        if $array_reference;

        # Output:
        $input                      =   $changes?   $filtered:
                                        $input;
        return $self;
    }
    
    method  $validate_input {

        # Initial Values:
        my  @errors                 =   ();
        my  $error_count            =   0;
        local $SIG{__WARN__}        =   sub {
                                            push @errors, sprintf('[%s] - %s', ++$error_count, shift);
                                        };
        my  $error_text = {

            intro                   =>  $new_line.'Please address these errors and try again:'.$new_line,
            
            pod                     =>  'Printing Plain Old Documentation below '.
                                        'should it prove helpful...'.$new_line,

            input_false             =>  'No value found '.
                                        "for object instance's input field / object attribute. ".
                                        $line_reference_prefix,

            expected_array_ref      =>  'Expected input to be an array reference.'.$new_line.
                                        'Found ref to return "%s".'.$new_line.
                                        'When dumped with Data::Dumper, input is as follows:'.$new_line.
                                        '%s'.
                                        $line_reference_prefix,

            empty                   =>  'Input array reference was found to be empty, '.
                                        'and needs to be populated with digits to proceed. '.
                                        $line_reference_prefix,

            not_even                =>  'Expected an even number of elements in the list of digits '.
                                        'and found %s element%s. '.
                                        $line_reference_prefix,

            not_all_integers        =>  'Expected input array reference to contain only integer digits.'.$new_line.
                                        'When dumped with Data::Dumper, input is as follows:'.$new_line.
                                        '%s'.
                                        $line_reference_prefix,

            plural                  =>  's',

            singular                =>  q{},

            exit_reason             =>  'Exiting due to %s error%s. '.
                                        $line_reference_prefix,

        };


        # Regular Expressions:

        my  $matches_integer        =  qr/^\p{Digit}+$/; # Does not allow decimal dots nor Roman Numerals.


        # Definitions:

        my  $array_reference        =   $input
                                        && (
                                            (ref $input) eq 'ARRAY'
                                        );

        my  $contains_items         =   $array_reference
                                        && $input->@*;

        my  $even_number_of_items   =   $contains_items
                                        && !( # Negated
                                            (scalar $input->@*) % 2
                                        );

        my  $all_integers           =   $contains_items
                                        && scalar $input->@* == scalar map {
                                            $ARG =~ $matches_integer? $ARG:
                                            ();
                                        } $input->@*;


        # Checks:

        warn                            $error_text->{'input_false'}
                                        unless $input;

        warn                            sprintf($error_text->{'expected_array_ref'}, (ref $input) , Dumper($input),)
                                        unless $array_reference;

        warn                            $error_text->{'empty'}
                                        unless $contains_items;

        warn                            sprintf(

                                            $error_text->{'not_even'}, scalar $input->@*,

                                            scalar $input->@* == 1? $error_text->{'singular'}:
                                            $error_text->{'plural'},

                                        )
                                        unless $even_number_of_items;

        warn                            sprintf($error_text->{'not_all_integers'}, Dumper($input),)
                                        unless $all_integers;



        # Output:

        if (@errors) {

            say                         join $new_line, ($error_text->{'intro'}, @errors);
            say                         $error_text->{'pod'};

            Pod::Text::Color->new->parse_from_file(__FILE__);

            die                         sprintf(

                                            $error_text->{'exit_reason'}, scalar @errors,

                                            (scalar @errors == 1)?  $error_text->{'singular'}:
                                            $error_text->{'plural'},

                                        );
        };

        return $self;

    }

    method  $process_input {

        # Initial Values:
        my  @equal_pairs                =   ();
        my  @sorted_input               =   sort {$a <=> $b} $input->@*;
        my  @full_range_of_input        =   (0..$#sorted_input);

        # Processing:
        for (@full_range_of_input) {

            last if ($#sorted_input < 1);

            my  ($a, $b)                =   (shift @sorted_input, shift @sorted_input);
            my  $equal_pair             =   $a == $b? [$a, $b]:
                                            undef;

            if ($equal_pair) {
                push    @equal_pairs    ,   $equal_pair;
            }
            else {
                unshift @sorted_input   ,  $b;
            };

        };

        # Output:
        @output                         =   @equal_pairs;
        return $self;

    }

=item input(@array);

    # Set input via array indirectly:
    my  @array              =   (3, 2, 3, 2, 2, 2);
    my  $equal_pairs_object =   EqualPairs->new->input(@array);

    # Set input via array directly:
    my  $equal_pairs_object =   EqualPairs->new->input(3, 2, 3, 2, 2, 2);

Returns the object instance for method chaining.
Requires that a list of values be provided as input,
and that the list adhere to validation rules,
or the script will be aborted/die.

To be valid, input must be an even numbered list of integer digits.

Automatically processes the input,
and sets the L<"output"|/output;> object attribute.

=cut

    method  input (@params) {
        $input  =   @params?   \@params:
                    $input;
        return      $self->$filter_input->$validate_input->$process_input;
    }

=item pretty_output;

    say EqualPairs->new->input(3, 2, 3, 2, 2, 2)->pretty_output;

Returns a string that can be displayed.
Uses the values of the object instance's output object attribute
(as can be obtained via the L<"output"|/output;> getter method)
to generate a friendly output message intended for screen display,
that lists the equal pairs the script has found after processing the input,
or states no equal pairs were found.

=back

=cut

    method  pretty_output {

        # Initial Values:
        my  $first          =   1;
        my  $text = {
            leader          =>  'Here are your equal pairs:'.$new_line.
                                'Output: ',
            blank           =>   'No equal pairs found.',
        };

        # Processing:
        my  $pretty_output  =   @output?    $text->{'leader'}:
                                $text->{'blank'};

        foreach my $pair (@output) {

            $pretty_output  .=  ','
                                unless $first;
            $first           =  undef if $first;
            $pretty_output  .=   '('.$pair->[0].','.$pair->[1].')';

        }

        # Output:
        return $pretty_output;

    }

=head1 AUTHOR

Andrew Mehta

=cut

}

package Ch_1 v1.0.0;
class   Ch_1 {
    use File::Basename;
    use lib dirname(__FILE__)."/lib";
    use CodeBoilerplate;

=pod Name, Version, Synopsis, Description

=encoding utf8

=head1 NAME

Ch_1 - Perl Weekly Challenge 249 - Task 1 (Set 25th December 2023).

=head1 VERSION

v1.0.0

=cut

=head1 SYNOPSIS

    # Run at the command line with input:
    perl ./Ch_1.pm 3 2 3 2 2 2

    # Use Perl Module:
    use Ch_1;
    my  @input              =   (3, 2, 3, 2, 2, 2);
    my  $answer_to_task_1   =   Ch_1->answer(@input);
    my  @equal_pairs        =   Ch_1->answer_data(@input);

=head1 DESCRIPTION

Contains L<"answer"|/answer(@array);>
and L<"answer_data"|/answer_data(@array);> methods
to the Perl Weekly Challenge 249 Task 1
(set 25th December 2023).
When executed (ran from the command line),
the L<"answer"|/answer(@array);> method is ran,
and its return value output to C<STDOUT>.

Alternatively, the script can be used as a Perl Module,
and the L<"answer"|/answer(@array);>
and L<"answer_data"|/answer_data(@array);> methods
invoked directly, returning a string for output
and an array of array references for data manipulation,
respectively.

Package omits...

    1;

...at the end, as this is not needed
with feature bundles v5.37 or higher,
as documented at
L<https://perldoc.perl.org/functions/require>.

=cut

=head1 CLASS METHODS

=over

=item answer(@array);

    use Ch_1;
    my  @input              =   (3, 2, 3, 2, 2, 2);
    my  $answer_to_task_1   =   Ch_1->answer(@input);

Outputs the answer to
Perl Weekly Challenge 249 Task 1
(set 25th December 2023).
Takes a list consisting of an even number of digits as input.
Returns a string containing output messages.

=back

=cut

    method answer :common (@input) {
        return EqualPairs->new->input(@input)->pretty_output;
    }

=over

=item answer_data(@array);

    use Ch_1;
    my  @input              =   (3, 2, 3, 2, 2, 2);
    my  @equal_pairs        =   Ch_1->answer_data(@input);

Takes a list consisting of an even number of digits as input.

Returns an array of array references,
where each array reference is a pair of equal integers.
This is the underlaying output data that
is used in the display-friendly L<"answer"|/answer(@array);>.

If no pairs of equal numbers are found,
will return an empty array.


=back

=cut

    method answer_data :common (@input) {
        return EqualPairs->new->input(@input)->output;
    }

    say Ch_1->answer(@ARGV) unless caller;  # If you omit the class name (Ch_1-> or __PACKAGE__->),
                                            # @input will be missing the first @ARGV value
                                            # - presumably shifted off to $self by Object::Pad.

=head1 AUTHOR

Andrew Mehta

=cut

}

__END__

Task 1: Equal Pairs
Submitted by: Mohammad S Anwar

You are given an array of integers with even number of elements.

Write a script to divide the given array into equal pairs such that:

a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.

=================

Example 1

Input: @ints = (3, 2, 3, 2, 2, 2)
Output: (2, 2), (3, 3), (2, 2)

There are 6 elements in @ints.
They should be divided into 6 / 2 = 3 pairs.
@ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the conditions.

Example 2

Input: @ints = (1, 2, 3, 4)
Output: ()

There is no way to divide @ints 2 pairs such that the pairs satisfy every condition.
