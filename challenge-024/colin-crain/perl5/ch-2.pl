#! /opt/local/bin/perl
#
#       inverted_index.pl
#
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my @docs = @ARGV;

say "enter search terms: ";
my @TEST_TERMS = split /\s/, <STDIN>;

my $idx = make_index( @docs );

my ($match, $all) = search_index($idx, @TEST_TERMS);

say "matched all:\n", (join ", ", $match->@*);
say "by prevalence:\n", (join "\n ", $all->@*);


## ## ## ## ## SUBS

sub make_index {
    my @documents = @_;

    my $idx = {};

    ## open and slurp down the file,
    ## split on whitespace to make a word list
    for my $file ( @documents ) {
        open (my $fh, "<" , $file) or die "can't open $file to read: $!\n";
        my @words = split /\s/, <$fh>;
        close $fh;

        ## run it through a unique filter
        my @unique_words = uniq( @words );

        ## add each word to the index adding the file to the value array
        for my $word ( @unique_words ) {
            if (exists $idx->{$word}) {
                push $idx->{$word}->@*, $file;
            }
            else {
                $idx->{$word} = [$file];
            }
        }
    }

    return $idx;
}

sub search_index {
## takes an index hashref and a list of search terms
## returns two lists, the first of docs with all terms
## the second a sorted list of documents by term prevalence
## ( most words found first, will include all documents with at least one word)
    my ($idx, @words) = @_;

    ## for each search term, add its index doc list to the result
    my @result;
    for my $search_term ( @words ) {
        if (exists $idx->{$search_term}) {
            push @result, $idx->{$search_term}->@*;
        }
    }

    ## count the document occurrences in the concatenated index lists
    my %result_count;
    foreach my $document ( @result ) {
        $result_count{$document}++;
    }
    my @unique_result = uniq( @result );

    ## if the occurence count equals the search term count, all terms match to the document
    my @all_terms = grep { $result_count{$_} == scalar @words } @unique_result;

    ## alternately, sort the unique result list on prevalence
    my @by_prevalence = sort { $result_count{$b} <=> $result_count{$a} } @unique_result;

    return (\@all_terms, \@by_prevalence);
}

sub uniq {
## filters a list for unique terms, with first occurence preserved
## we could grab List::Util::uniq but here we roll our own with the "seen" trick
    my %seen;
    return grep { ! $seen{$_}++ } @_;
}


