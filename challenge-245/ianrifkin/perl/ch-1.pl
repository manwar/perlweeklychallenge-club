use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;

# Task 1: Sort Language

my $man = 0;
my $help = 0;
GetOptions ('help|?' => \$help, man => \$man
    )
    or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Example 1
my @lang = ('perl', 'c', 'python');
my @popularity = (2, 1, 3);
say sort_lang(\@lang, \@popularity);
#Output: ('c', 'perl', 'python')

#Example 2
@lang = ('c++', 'haskell', 'java');
@popularity = (1, 3, 2);
say sort_lang(\@lang, \@popularity);
#Output: ('c++', 'java', 'haskell')
    
sub sort_lang {
    my ($lang, $popularity) = @_;
    # Get indices of popularity array in sort order
    my @pop_sort_idx = sort { $popularity[$a] <=> $popularity[$b] } 0 .. $#popularity;
    # Return sorted language array using indices of sorted popularity numbers
    return "@lang[@pop_sort_idx]";
}

__END__

=head1 Challenge 245, Task 1: Sort Language, by IanRifkin

You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

Example 1
Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')
Example 2
Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')

See https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK1 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-1.pl [options]

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back




