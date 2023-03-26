#!perl

################################################################################
=comment

Perl Weekly Challenge 209
=========================

TASK #2
-------
*Merge Account*

Submitted by: Mohammad S Anwar

You are given an array of accounts i.e. name with list of email addresses.

Write a script to merge the accounts where possible. The accounts can only be
merged if they have at least one email address in common.

Example 1:

  Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                       ["B", "b1@b.com"],
                       ["A", "a3@a.com", "a1@a.com"] ]
                     ]

  Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
            ["B", "b1@b.com"] ]

Example 2:

  Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                       ["B", "b1@b.com"],
                       ["A", "a3@a.com"],
                       ["B", "b2@b.com", "b1@b.com"] ]

  Output: [ ["A", "a1@a.com", "a2@a.com"],
            ["A", "a3@a.com"],
            ["B", "b1@b.com", "b2@b.com"] ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumptions
-----------
1. Accounts OF THE SAME NAME can be merged only if they have at least one email
   address in common.
2. "Having an email address in common" is a transitive relation, so two accounts
   with the same name but with no addresses in common can be merged if each has
   an address in common with (say) a third account of the same name.

Note
----
No attempt is made to verify the format of email addresses.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Set::Scalar;
use Test::More;
use Text::CSV;

const my $INDENT => ' ' x 8;
const my $USAGE  =>
"Usage:
  perl $0 <file>
  perl $0

    <file>    Name of accounts file\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 209, Task #2: Merge Account (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $accounts = read_accounts_file( $ARGV[ 0 ] );

        print format_accounts( "Input:  \@accounts", $accounts ), "\n";

        my $merged   = merge_accounts( $accounts );

        print format_accounts( "Output: \@merged",   $merged );
    }
    else
    {
        error( "Expected 1 or 0 command line arguments, found $args" );
    }
}

#-------------------------------------------------------------------------------
sub merge_accounts
#-------------------------------------------------------------------------------
{
    my ($accounts) = @_;
    my (%name2accounts, @merged);

    for my $account (@$accounts)
    {
        my ($name, @addresses) = @$account;
        push @{ $name2accounts{ $name } }, \@addresses;
    }

    for my $name (sort keys %name2accounts)
    {
        L_LOOP:
        {
            my $accounts = $name2accounts{ $name };

            for my $i (0 .. $#$accounts - 1)
            {
                my $s = Set::Scalar->new( @{ $accounts->[ $i ] } );

                for my $j ($i + 1 .. $#$accounts)
                {
                    my $t   = Set::Scalar->new( @{ $accounts->[ $j ] } );
                    my $int = $s->intersection( $t );

                    if ($int->size > 0)
                    {
                        $accounts->[ $i ] = [ sort $s->union( $t )->members ];
                        splice @$accounts, $j, 1;
                        redo L_LOOP;
                    }
                }
            }

            push @merged, [ $name, @$_ ] for @$accounts;
        }
    }

    return \@merged;
}

#-------------------------------------------------------------------------------
sub read_accounts_file
#-------------------------------------------------------------------------------
{
    my ($filename) = @_;
    -e  $filename or error( qq[File "$filename" not found] );

    my @accounts;
    my $csv = Text::CSV->new(
                                {
                                    allow_loose_quotes => 1,
                                    auto_diag          => 1,
                                    binary             => 1,
                                }
                            );

    open( my $fh, '<', $filename )
        or die "Cannot open file $filename for reading, stopped";

    while (my $row = $csv->getline( $fh ))
    {
        push @accounts, $row;
    }

    close $fh
        or die "Cannot close file $filename, stopped";

    return \@accounts;
}

#-------------------------------------------------------------------------------
sub format_accounts
#-------------------------------------------------------------------------------
{
    my ($header, $accounts) = @_;

    return sprintf "$header =\n%s[\n%s\n%s]\n",
        $INDENT,
        join
        (
            ",\n",
            map
            {
                $INDENT . '  [' . join( ', ', map { qq["$_"] } @$_ ) . ']'

            } @$accounts
        ),
        $INDENT;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $in_file, $out_file) = split / \| /x, $line;
        my  $got = merge_accounts( read_accounts_file( $in_file  ) );
        my  $expected =            read_accounts_file( $out_file );

        is_deeply $got, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1 |Example_1.txt |Example_1_answer.txt
Example 2 |Example_2.txt |Example_2_answer.txt
Transitive|Transitive.txt|Transitive_answer.txt
