#!/usr/bin/env perl6
#       sordid_emails.raku
#
#         TASK #1 › Sort Email Addresses
#         Submitted by: Neil Bowers
#         Reviewed by: Ryan Thompson
#
#             Write a script that takes a list of email addresses (one per line)
#             and sorts them first by the domain part of the email address, and
#             then by the part to the left of the @ (known as the mailbox).
#
#             Note that the domain is case-insensitive, while the mailbox part is
#             case sensitive. (Some email providers choose to ignore case, but
#             that’s another matter entirely.)
#
#             If your script is invoked with arguments, it should treat them as
#             file names and read them in order, otherwise your script should read
#             email addresses from standard input.
#
#         Bonus
#
#             Add a -u option which only includes unique email addresses in the
#             output, just like sort -u.
#
#         Example
#
#             If given the following list:
#
#                 name@example.org
#                 rjt@cpan.org
#                 Name@example.org
#                 rjt@CPAN.org
#                 user@alpha.example.org
#
#             Your script (without -u) would return:
#
#                 user@alpha.example.org
#                 rjt@cpan.org
#                 rjt@CPAN.org
#                 Name@example.org
#                 name@example.org
#
#             With -u, the script would return:
#
#                 user@alpha.example.org
#                 rjt@CPAN.org
#                 Name@example.org
#                 name@example.org
#           METHOD:
#
#             In Raku, we don’t have the convenience of the diamond
#             operator, so we do need to manage our input a little more.
#             This is made up for in other ways, as we can more easily
#             specify the transformations required before determining
#             uniqueness and sort ordering. Being able to specify the
#             :as(&{BLOCK}) adjective to the built-in unique routine is
#             a particularly useful addition, which allows us to attach
#             an arbitrary which will determine the specifications for
#             our uniqueness test. The sort specifications are
#             streamlined as well; providing a routine that takes one
#             parameter will be applied as an {$a cmp $b} sort
#             automatically, and if given a list of such functions will
#             chain them to resolve equivalencies like using || in a
#             Perl 5 sort.
#
#             Command line flags are handled in the signature directly
#             by the inclusion of an optional Boolean type, here as Bool
#             :$u?=False. If a -u switch is included, it will come up as
#             $u = True, allowing us to test for it within the MAIN
#             block directly.
#
#           2020 Colin Crain

sub MAIN(Bool :$u?=False, *@files) {
    my @addr;

    ## if no files on the commandline, look for lines coming in from STDIN
    if @files.elems {
        @addr.append( .IO.lines ) for @files;
    }
    else {
        @addr = $*IN.lines;
    }

    ## filter unique items after applying lowercase to domain
    @addr .= unique(:as(&{ S:i/(\@.*$)/{lc($/)}/ })) if $u;

    ## sort by lowercased domain then by mailbox
    my @sorted = @addr.sort(&{.substr(.index("@")+1).lc, .substr(0,(.index("@")))});

    .say for @sorted;
}
