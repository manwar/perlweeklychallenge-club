use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 062
=========================

Task #1
-------
*Sort Email Addresses*

*Submitted by: Neil Bowers*
*Reviewed by: Ryan Thompson*

Write a script that takes a list of email addresses (one per line) and sorts
them first by the domain part of the email address, and then by the part to the
left of the @ (known as the mailbox).

Note that the domain is case-insensitive, while the mailbox part is case
sensitive. (Some email providers choose to ignore case, but that's another
matter entirely.)

If your script is invoked with arguments, it should treat them as file names and
read them in order, otherwise your script should read email addresses from
standard input.

*Bonus*

Add a -u option which only includes unique email addresses in the output, just
like sort -u.

*Example*

If given the following list:

  name@example.org
  rjt@cpan.org
  Name@example.org
  rjt@CPAN.org
  user@alpha.example.org

Your script (without -u) would return:

  user@alpha.example.org
  rjt@cpan.org
  rjt@CPAN.org
  Name@example.org
  name@example.org

With -u, the script would return:

  user@alpha.example.org
  rjt@CPAN.org
  Name@example.org
  name@example.org

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Str constant $EOF = $*VM.osname.lc eq 'mswin32' ?? 'Enter Ctrl-Z'
                                                   !!       'Ctrl-D';

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
multi sub MAIN
(
    Bool:D :$u = False,     #= Include only unique email addresses in the output
           *@files,         #= Name(s) of file(s) containing email addresses (1
                            #=   per line)
)
#===============================================================================
{
    "Challenge 062, Task #1: Sort Email Addresses (Raku)\n".put;

    my Str @addresses;

    for @files -> Str $file
    {
        for $file.IO.lines -> Str $line
        {
            @addresses.push: $line.trim;
        }
    }

    sort-addresses($u, @addresses);
}

#===============================================================================
multi sub MAIN
(
    Bool:D :$u = False,     #= Include only unique email addresses in the output
)
#===============================================================================
{
    "Challenge 062, Task #1: Sort Email Addresses (Raku)\n".put;

    my Str @addresses;

    "Enter email addresses (one per line, $EOF to terminate):".put;

    while my Str $line = $*IN.get
    {
        push @addresses, $line.trim;
    }

    ''.put;

    sort-addresses($u, @addresses);
}

#-------------------------------------------------------------------------------
# Note: Sorting could be accomplished in a more straightforward way by simply
#       converting the domain to all lower case up front. The more complex
#       approach taken below is designed to make the output exactly match that
#       given in the Example section of the Task description.
#
sub sort-addresses( Bool:D $unique, *@addresses )
#-------------------------------------------------------------------------------
{
    my %address-parts;

    for @addresses -> Str $address
    {
        $address ~~ / ^ ( <-[ @ ]>+ ) \@ ( <-[ @ ]>+ ) $ /
            or die "ERROR: \"$address\" is not a valid email address";

        my ($mailbox, $domain) = $0, $1;

        my $new-address = $address;
           $new-address = $mailbox ~ '@' ~ $domain.lc if $unique;

        %address-parts{ $new-address } = [ $mailbox, $domain ];
    }

    my Str @sorted = sort
           {
               %address-parts{ $^a }[1].lc cmp %address-parts{ $^b }[1].lc ||
               %address-parts{ $^a }[0]    cmp %address-parts{ $^b }[0]

           }, $unique ?? %address-parts.keys !! @addresses;

    @sorted = @sorted.map: { %address-parts{$_}.list.join: '@' } if $unique;

    "%s\n\n".printf: $unique ?? "Unique, sorted email addresses:"
                             !! "Sorted email addresses:";

    .put for @sorted;
}

################################################################################
