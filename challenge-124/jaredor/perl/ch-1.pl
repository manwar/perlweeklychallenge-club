#!/usr/bin/env perl

# TWC 124, TASK #1 : Happy Women Day

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

# For this challenge

use Data::Dump qw(pp);

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'help|h!'   => \( my $help ),
    'task|t!'   => \( my $task ),
    'test'      => \( my $test ),
    'lazy'      => \( my $lazy ),
    'superlazy' => \( my $superlazy ),
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

$test ? test() : run(@ARGV);

exit;    # End of main script.

sub run {

    # Bundle up fatal input errors to report them all at once.

    my @errors;

    push @errors, "This script takes no arguments." if @_;

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.


    my $ansfmt = { generate => undef, wchar => undef, size => undef, };

    if ($lazy) {
        $ansfmt->{generate} = \&lazy;
    } elsif ($superlazy) {
        $ansfmt->{generate} = \&superlazy;
    } else {
        $ansfmt->{generate} = \&superlazy;
    }

    output_results( $ansfmt, @_ );
}

# The main algorithms

sub lazy {

    my $graphical = "   ^^^^^\n" .
                    "  ^     ^\n" .
                    " ^       ^\n" .
                    "^         ^\n" .
                    "^         ^\n" .
                    "^         ^\n" .
                    "^         ^\n" .
                    "^         ^\n" .
                    " ^       ^\n" .
                    "  ^     ^\n" .
                    "   ^^^^^\n" .
                    "     ^\n" .
                    "     ^\n" .
                    "     ^\n" .
                    "   ^^^^^\n" .
                    "     ^\n" .
                    "     ^\n";
    return $graphical;
}

sub superlazy {
    binmode(STDOUT,"utf8");
    return "\x{2640}";
}


# Report to STDOUT from user command line input.

sub output_results {

    my $ansfmt = shift;
    say $ansfmt->{generate}->();

}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    # I'm too lazy to test the lazy answer.

    # Ironically, I will test the superlazy answer.
    is_deeply( [ superlazy() ], [ "\x{2640}" ], "Unicode symbol checks out." );

    done_testing();
}

__END__

=head1 NAME

TWC 124, TASK #1 : Happy Women Day

=head1 SYNOPSIS

  ch-1.pl [options]

  Description:    Print the Venus Symbol.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test
    --lazy        Provide the lazy answer: Cut-and-paste from problem statement.
    --superlazy   Provide the super-lazy answer: Unicode

  Arguments:
    None.

=head1 OPTIONS

=over 8

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=item B<--test>

Run the embedded test suite for this script.

=item B<--lazy>

Given the lack of requirements in the problem statement, a simple cut-and-paste suffices as an answer. Provide such in this case.

=item B<--superlazy>

Unicode has a symbol for the Venus symbol. Provide it.

=back

=head1 DESCRIPTION

B<L<The Weekly Challenge, TASK #1 E<gt> Happy Women Day|https://theweeklychallenge.org/blog/perl-weekly-challenge-124/#TASK1>>

I<Submitted by: Mohammad S Anwar>

Write a script to print the Venus Symbol, international gender symbol for women. Please feel free to use any character.

        ^^^^^
       ^     ^
      ^       ^
     ^         ^
     ^         ^
     ^         ^
     ^         ^
     ^         ^
      ^       ^
       ^     ^
        ^^^^^
          ^
          ^
          ^
        ^^^^^
          ^
          ^


=head1 INTERPRETATION

Give a vague problem description, get a variety of answers....

The two cheeky answers are perhaps good to reflect upon. It seems like cheating, but both satisfy the brief. Something to think about when sending coding tasks out-of-shop to contractors.

=cut
