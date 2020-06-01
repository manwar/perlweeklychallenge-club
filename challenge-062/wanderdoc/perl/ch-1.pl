#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script that takes a list of email addresses (one per line) and sorts them first by the domain part of the email address, and then by the part to the left of the @ (known as the mailbox).
Note that the domain is case-insensitive, while the mailbox part is case sensitive. (Some email providers choose to ignore case, but that's another matter entirely.)

If your script is invoked with arguments, it should treat them as file names and read them in order, otherwise your script should read email addresses from standard input.
Bonus: Add a -u option which only includes unique email addresses in the output, just like sort -u.
Example:
If given the following list:

name@example.org rjt@cpan.org Name@example.org rjt@CPAN.org user@alpha.example.org

Your script (without -u) would return:
user@alpha.example.org rjt@cpan.org rjt@CPAN.org Name@example.org name@example.org
With -u, the script would return:
user@alpha.example.org rjt@CPAN.org Name@example.org name@example.org 
=cut

use Getopt::Std;
my %options=();

getopts("u", \%options);

my @addresses;
while ( my $arg = shift @ARGV )
{
     if ( -f $arg )
     {
          read_file($arg);
     }
     else
     {
          push @addresses, $arg;
     }
}


my %uniq;
@addresses = defined $options{u} ?
          map {$_->[1]}
          sort { lc $a->[0][1] cmp lc $b->[0][1] or $a->[0][0] cmp $b->[0][0]}
          grep { (! $uniq{ $_->[0][0] . '@' . lc($_->[0][1]) }++) }
          sort {$a->[0][1] cmp $b->[0][1] } 
          map {[[(split(/@/,$_))], $_]}
          @addresses 

     : 
          map { $_->[1] }
          sort {lc $a->[0][1] cmp lc $b->[0][1] or $a->[0][0] cmp $b->[0][0]}
          map {[[(split(/@/,$_))], $_]} 
          @addresses;

print $/;
print join(" ", @addresses), $/;

sub read_file
{
     my $file = $_[0];
     open my $in, "<", $file or die "$!";
     while ( my $line = <$in> )
     {
          chomp $line;
          $line =~ s/^\s*//;

          $line =~ s/\s*$//;
          push @addresses, $line;
     }
}