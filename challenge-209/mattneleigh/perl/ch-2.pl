#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @account_groups = (
    # Given cases
    [
        [ "A", "a1\@a.com", "a2\@a.com" ],
        [ "B", "b1\@b.com" ],
        [ "A", "a3\@a.com", "a1\@a.com" ]
    ],
    [
        [ "A", "a1\@a.com", "a2\@a.com" ],
        [ "B", "b1\@b.com" ],
        [ "A", "a3\@a.com" ],
        [ "B", "b2\@b.com", "b1\@b.com" ]
    ],

    # Additional test cases- multiple disjoint
    # accounts for 'X', an account with multiple
    # address matches within one of the sets of
    # 'X', a chain of address matches across
    # three accounts within 'Z', etc.
    [
        [ "X", "x1\@x.com", "x2\@x.com" ],
        [ "X", "x2\@x.com", "x3\@x.com" ],
        [ "Y", "y1\@x.com", "y2\@x.com" ],
        [ "X", "x7\@x.com", "x8\@x.com" ],
        [ "Z", "z1\@z.com", "z2\@z.com" ],
        [ "X", "x5\@x.com", "x6\@x.com" ],
        [ "Z", "z2\@z.com", "z3\@z.com" ],
        [ "X", "x4\@x.com", "x5\@x.com", "x6\@x.com" ],
        [ "Z", "z3\@z.com", "z4\@z.com" ],
        [ "Y", "y2\@x.com", "y3\@x.com" ]
    ]
);

print("\n");
foreach my $account_group (@account_groups){
    printf(
        "Input: \@accounts = (\n%s                   )\n",
        list_of_lists_to_indented_block(
            23,
            @{$account_group}
        )
    );

    merge_accounts($account_group);

    printf(
        "Output: (\n%s        )\n\n",
        list_of_lists_to_indented_block(
            12,
            @{$account_group}
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of account data structures in a specified format (see below)
# merge accounts that have the same name and common e-mail addresses among
# them, and sort addresses alphanumerically in all cases
# Takes one argument:
# * A ref to an array of account data arrays, which must each be organized as
#   follows: [ "NAME", "addr1", "addr2" ... "addrN" ]
#   where "NAME" is the account holder's name, and "addr1"-"addrN" are valid
#   e-mail addresses used by the account holder.  Given the following data
#   structure:
#
#   [
#       [ "jsmith", "jsmith@foo.com", "jsmith@bar.com" ],
#       [ "tbaker", "tbaker@foo.com", "tbaker@baz.com" ],
#       [ "jsmith", "notthatjsmith@foo.com", "theotherjsmith@bar.com" ],
#       [ "jsmith", "jsmith@foo.com", "jsmith@baz.com" ]
#   ]
#
#   This function will convert it to:
#
#   [
#       [ "jsmith", "jsmith@bar.com", "jsmith@baz.com", "jsmith@foo.com" ],
#       [ "jsmith", "notthatjsmith@foo.com", "theotherjsmith@bar.com" ],
#       [ "tbaker", "tbaker@baz.com", "tbaker@foo.com" ]
#   ]
#
# Returns:
# * 0 in all cases, which conveys no meaningful information
# NOTE: THE SUPPLIED DATA STRUCTURE AND ITS CONTENTS WILL BE MODIFIED IN-PLACE
# OR DELETED AS REQUIRED; if the original must be maintained, a deep copy must
# be made before calling this function.
################################################################################
sub merge_accounts{

    my %accounts_by_name;

    # Set up a structure of accounts, keyed
    # by name, moving the appropriate
    # references from the original account
    # data structure, which is disassembled
    # in the process
    while(scalar(@{$ARG[0]})){
        my $account = shift(@{$ARG[0]});

        push(
            @{$accounts_by_name{$account->[0]}},
            $account
        );
    }

    # Loop over all names
    foreach my $name (keys(%accounts_by_name)){
        my $lists = $accounts_by_name{$name};
        my $prime = 0;

        # Loop from the start to the second-
        # to-last account with the current
        # name, designating these as prime
        # accounts, into which subsequent
        # matching accounts will be merged;
        # the list of accounts may be
        # shrinking as we work
        while($prime < $#$lists){
            my $current = $prime + 1;

            # Loop from one past the prime account
            # to the end of the list- these accounts
            # will be merged into the prime account
            # if an address matches, so the list
            # may be shrinking
            while($current <= $#$lists){
                my $match = 0;

                # Loop over each address in the prime
                # account; this list will NOT expand
                # until the merging later on, if
                # applicable
                for my $prime_index (1 .. $#{$lists->[$prime]}){
                    my $current_index = 1;

                    # Loop over each address in the current
                    # account; this list may be shrinking if
                    # matches are found
                    while($current_index <= $#{$lists->[$current]}){
                        if(
                            $lists->[$prime][$prime_index]
                            eq
                            $lists->[$current][$current_index]
                        ){
                            # There was a match with the prime
                            # account- remove the match from the
                            # current account and make a note
                            splice(@{$lists->[$current]}, $current_index, 1);
                            $match = 1;
                        } else{
                            # No match- move on to the next item
                            $current_index++;
                        }
                    }
                }

                if($match){
                    # There was a match between an address
                    # in the prime account and at least one
                    # address in the current account- merge
                    # the remaining addresses (matching
                    # addresses were already removed) into
                    # the prime account, then discard the
                    # current account, shrinking the account
                    # list for the current name
                    push(
                        @{$lists->[$prime]},
                        splice(@{$lists->[$current]}, 1)
                    );
                    splice(@{$lists}, $current, 1);
                } else{
                    # No match- move on to the next current
                    # account
                    $current++;
                }
            }

            # Advance to the next prime account
            $prime++;
        }

    }

    # Move references to the merged account
    # information back into the original
    # data structure, which is reconstructed
    # in the process
    foreach my $name (sort(keys(%accounts_by_name))){
        while(scalar(@{$accounts_by_name{$name}})){
            my $account = shift(@{$accounts_by_name{$name}});
            my $name;

            # Sort the addresses while leaving the
            # name field at the start of the list
            push(
                @{$account},
                sort(splice(@{$account}, 1))
            );

            # Add the account to the original data
            # structure
            push(
                @{$ARG[0]},
                $account
            );
        }
        delete($accounts_by_name{$name});
    }

    return(0);

}



################################################################################
# Build an indented block of text out of a list of lists
# Each individual list will be presented as the code that would produce an
# array ref of quoted strings containing the equivalent data, one per line; a
# single string with embedded newlines is returned
# Takes two arguments:
# * The number of spaces to indent (e.g. 4 )
# * The list of lists to stringify (e.g. ( [ 1, 2 ], [ 3, 4 ] ) )
# Returns
# * A single string containing an indented text representation of contents of
#   the list of lists (e.g. "    [ "1", "2" ]\n    [ "3", "4" ]\n" )
################################################################################
sub list_of_lists_to_indented_block{

    my $format_string = (" " x shift()) . "[ %s ]\n";

    return(
        join(
            "",
            map(
                sprintf(
                    $format_string,
                    list_to_quoted_string(@{$_})
                ),
                @ARG
            )
        )
    );

}



################################################################################
# Build a quoted, comma-separated string out of the contents of a list
# Takes one argument:
# * The list (e.g. ( 1, 2, 3, 4 ) )
# Returns:
# * A quoted, comma-separated string containing the contents of the list (e.g.
#   ""1", "2", "3", "4"" )
################################################################################
sub list_to_quoted_string{

    return(
        # (2) Join the quoted strings together
        # with commas
        join(
            ", ",
            # (1) Put quotes around each list member
            map(
                "\"".$_."\"",
                @ARG
            )
        )
    );

}



