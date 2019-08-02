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

    # Challenge 2

    find_most_anagrams($dict);
}

sub find_most_anagrams
{
    my ($dict) = @_;
    my  $max   = 0;
    my  @max_keys;

    for my $key (keys %$dict)
    {
        my $count = scalar $dict->{$key}->@*;
        if ($count >= $max)
        {
            @max_keys = () if $count > $max;
            $max = $count;
            push @max_keys, $key;
        }
    }

    if (scalar @max_keys == 1)
    {
        my $key = $max_keys[0];
        printf "\nThe sequence of characters with the most anagrams is '%s' " .
               "with %d:\n%s\n", $key, $max, join(', ', $dict->{$key}->@*);
    }
    else
    {
        printf "\nThere are %d character sequences that produce %d anagrams " .
               "each:\n", scalar @max_keys, $max;
        for my $key (sort @max_keys)
        {
            printf "\n'%s' produces:\n%s\n", $key,
                   join( ', ', $dict->{$key}->@* );
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
