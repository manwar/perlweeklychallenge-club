#! /opt/local/bin/perl
#
#       sordid_emails.pl
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
#
#         METHOD:
#
#         In Perl, having cascading sort criteria makes sorts like this
#         pretty straightforward, once we’ve figured out what those
#         criteria are and how to reach the relevant data. In this case
#         we need to separate out the domain portion of the address and
#         lowercase it (or uppercase, if you’re the shouty type) and
#         first sort by that, once that is finished we need to separate
#         out the mailbox as well and secondarily sort indeterminate
#         items on that.
#
#         The unique filter is a little interesting because we need to
#         do a transformation of the addresses first before we can
#         determine what “unique” means under these circumstances. In
#         this we need to lowercase (again: or upper if you like to
#         shout where no one can possibly hear you) only the domain
#         portion of the address so as to make that portion
#         case-insensitive.
#
#         Because the sorting requires us to selectively look at only
#         portions of the address at any one time, we will need to
#         dissect the address into its mailbox and domain components.
#         For the Perl solution, we will split on the ‘@’ symbol
#         required in every email address and examine the resulting
#         array elements.
#
#         For the unique filter we will modify the idiom of populating a
#         %seen hash and checking for key existence. We will need to
#         compare whole addresses as viewed through a certain lens, so
#         we will modify the strings using non-destructive substitution
#         and use these as hash keys.
#
#         One noteworthy difference in this change is the quite specific
#         user interface; rather than a logical proof of concept we are
#         being asked to implement a full-blown command line tool.
#         Fortunately for us Perl grew out of an intimate relationship
#         with the UNIX command line, so it contains many little tweaks
#         that have evolved out of that growth. One of these is the
#         behavior of the Diamond Operator <>, a specially wrought
#         filehandle-like thing which reads lines either preferentially
#         from a list of files in @ARGV, opening them sequentially until
#         there are no more, or in the absence of files, from STDIN.
#         This is not coincidentally the way many, many command line
#         tools work and so conveniently exactly the behavior specified
#         in the challenge. In list context it’s slurpy and so @lines =
#         <> will deliver us our list of email addresses no matter how
#         they are presented.
#
#         To bring in the -u switch we will use the core module
#         Getopt:Std. A few lines of code:
#
#             my %options=();
#             getopts("u", \%options);
#
#         will then allow us to access $options{u} as a boolean. To
#         actually implement the behavior once we’ve turned it on we
#         simply grep the email list using the %seen variant described
#         above, to prune it before we waste time sorting.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use Getopt::Std;

# declare the perl command line flag '-u'
my %options=();
getopts("u", \%options);


## ## ## ## ## MAIN:

my @list = <>;
chomp @list;

my $sort = \&complex_sorter;
my @sorted = sort $sort @list;

## optionally apply -u switch
@sorted = unique(@sorted) if $options{u};

say $_ for @sorted;


## ## ## ## ## SUBS:

sub complex_sorter {
## sorts case insensitive on domain
## case sensitive on mailbox
## returns -1, 0, 1®
    my @a_list = split /(@)/, $a;
    my @b_list = split /(@)/, $b;

    lc($a_list[2]) cmp lc($b_list[2])
    ||
    $a_list[0] cmp $b_list[0]
}

sub unique {
## filters a list for unique email, with first occurence preserved
## domain case-insensitive
    my %seen;
    return grep { ! $seen{ s/(\@.*$)/lc($1)/er }++ } @_;
}
