#!perl

use strict;
use warnings;
use Const::Fast;

# Downloaded from https://crosswordman.com/wordlist.html:
const my $WORDFILE => 'UK Advanced Cryptics Dictionary.txt';
const my @DEFAULT  =>  qw( parses );

$| = 1;

MAIN:
{
    my $dict = init_dict();

    # Challenge 1

    find_anagrams($dict, @ARGV ? @ARGV : @DEFAULT);
}


sub find_anagrams
{
    my ($dict, @input) = @_;

    for my $word (@input)
    {
        my $target   = $word =~ s/[^A-Za-z]//gr;
        my $key      = join '', sort split //, $target;
        my @anagrams = $dict->{$key}->@*;
        @anagrams = grep { $_ ne $target } @anagrams;

        if (@anagrams)
        {
            printf "\nFound %d anagrams of '%s':\n%s\n", scalar @anagrams,
            $word, join(', ', @anagrams);
        }
        else
        {
            printf "\nNo anagrams of '%s' found\n", $word;
        }
    }
}

sub init_dict
{
    my %dict;

    open(my $fh, '<', $WORDFILE)
        or die "Cannot open file '$WORDFILE' for reading, stopped";

    while (<$fh>)
    {
        next if 1 .. / ^ -+ $ /x;       # Skip header
        chomp;
        push $dict{ join '', sort split //, $_ }->@*, $_;
    }

    close $fh
        or die "Cannot close file '$WORDFILE', stopped";

    return \%dict;
}
