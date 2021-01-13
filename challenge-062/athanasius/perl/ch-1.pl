#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $EOF   => lc $^O eq 'mswin32' ? 'Enter Ctrl-Z' : 'Ctrl-D';
const my $USAGE => "USAGE: perl $0 [ -u ] [ <filename>+ ]";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 062, Task #1: Sort Email Addresses (Perl)\n\n";

    my ($addresses, $unique) = get_input();
    my  $sorted_addresses    = sort_addresses($addresses, $unique);

    if ($unique)
    {
        print "Unique, sorted email addresses:\n\n";
    }
    else
    {
        print "Sorted email addresses:\n\n";
    }

    print "$_\n" for @$sorted_addresses;
}

#-------------------------------------------------------------------------------
# Note: Sorting could be accomplished in a more straightforward way by simply
#       converting the domain to all lower case up front. The more complex
#       approach taken below is designed to make the output exactly match that
#       given in the Example section of the Task description.
#
sub sort_addresses
#-------------------------------------------------------------------------------
{
    my ($addresses, $unique) = @_;
    my  %address_parts;

    for my $address (@$addresses)
    {
        $address =~ / ^ ( [^@]+ ) @ ( [^@]+ ) $ /x
            or die "ERROR: \"$address\" is not a valid email address\n";

        my ($mailbox, $domain) = ($1, $2);

        $address = $mailbox . '@' . lc $domain if $unique;

        $address_parts{ $address } = [ $mailbox, $domain ];
    }

    my @sorted = sort
                 {
                     lc $address_parts{$a}[1] cmp lc $address_parts{$b}[1] ||
                        $address_parts{$a}[0] cmp    $address_parts{$b}[0]

                 } $unique ? keys %address_parts : @$addresses;

    return $unique ? [ map { join '@', $address_parts{$_}->@* } @sorted ] :
                     \@sorted;
}

#-------------------------------------------------------------------------------
sub get_input
#-------------------------------------------------------------------------------
{
    my $addresses;
    my $unique = '';

    GetOptions('unique' => \$unique)
        or die "ERROR: Invalid command line\n$USAGE\n";

    if (@ARGV)
    {
        for my $filename (@ARGV)
        {
            open(my $fh, '<', $filename)
                or die "ERROR: Cannot open file \"$filename\" for reading:\n" .
                       "       $!";

            $addresses = read_addresses($fh);

            close $fh
                or die "ERROR: Cannot close file \"$filename\":\n       $!";
        }
    }
    else
    {
        print "Enter email addresses (one per line, $EOF to terminate):\n";

        $addresses = read_addresses(\*STDIN);

        print "\n";
    }

    return ($addresses, $unique);
}

#-------------------------------------------------------------------------------
sub read_addresses
#-------------------------------------------------------------------------------
{
    my ($fh) = @_;
    my  @addresses;

    while (my $line = <$fh>)
    {
        $line =~ s/ ^ \s+   //x;    # Remove leading  whitespace (if any)
        $line =~ s/   \s+ $ //x;    # Remove trailing whitespace (incl. newline)

        push @addresses, $line;
    }

    return \@addresses;
}

################################################################################
