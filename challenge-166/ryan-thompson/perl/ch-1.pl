#!/usr/bin/env perl
#
# pwc_hexwords.pl - Hexwords for PWC
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.016;
use warnings;
use strict;
use File::Slurper qw< read_lines >;
use List::Util    qw< sum max >;
use Getopt::Long;
no warnings 'uninitialized';

sub filter(_);

my %o = (       dict => '../../../data/dictionary.txt', 
              length => 8, 
           'max-sub' => 0.2,
        'min-length' => 3,
              pretty => 1
);
GetOptions(\%o, qw< dict=s max-sub=f length=i min-length=i pretty! >);

my %words =  map {            @$_          }
            grep {          filter         }
             map { [$_ => y/olist/01157/r] }
            grep {  /^[0-9a-folist]{2,}$/  } read_lines($o{dict});

my @words   = sort keys %words;
my @phrases = get_phrases();

$o{pretty} ? pretty_print(@phrases) 
           : say join '', map { $words{$_} } @$_ for @phrases;

# Pretty print the output
sub pretty_print {
    my $spaces = -1 + max map { 0+@$_ } @_;
    for (@_) {
        my $phrase = join ' ', map ucfirst, @$_;
        my $hexphrase = join '', map { $words{$_} } @$_;
        printf "%@{[$o{length}+$spaces]}s => %$o{length}s\n",
                $phrase, $hexphrase;
    }
}

# Get unique n-word phrases of length $o{length} (recursive)
sub get_phrases {
    my @phrases;

    sub {
        my $len = sum map { length } @_;

                                return if $len >  $o{length};
        push @phrases, [@_] and return if $len == $o{length};

        __SUB__->(@_, $_) for grep { $_ ge $_[-1] } @words;
    }->();

    @phrases;
}

# Perform any desired filtering of results. Takes an array of
# [ orig_word => hex_word ] and returns true if it should be included
sub filter(_) {
    my ($orig, $hex) = @{$_[0]};

    # Count number of substitutions in the word
    my $subs =()= ($orig ^ $hex) =~ /[^\0]/g;
    return if $subs > length($hex)*$o{'max-sub'};

    return if length($hex) > $o{length};
    return if length($hex) < $o{'min-length'};

    return 1; # pass
}
