package main;
use strict;
use warnings;

my %seen_letters;
my @output;

sub is_abcd {
    my $what = shift;

    return $what eq join( '', sort( split //, $what ) );
}

sub process_word {
    my $what = shift;

    my %this_run_letters = %seen_letters;

    for my $i ( split //, $what ) {
        $this_run_letters{$i} = 1;
    }
    my $letters_count = scalar keys %this_run_letters;

    if ( scalar keys %seen_letters == $letters_count - 1 ) {

        # we added a letter
        push @output, $_;
        %seen_letters = %this_run_letters;
    }

    return;
}

sub get_abcdrian_pangram {

    # only abecederian words solving exactly one letter
    open my $file, '<', 'dictionary.txt';

    while (<$file>) {
        chomp;
        process_word($_);

        # seen all letters?
        return join( ' ', @output ) if scalar keys %seen_letters == 26;
    }
    close $file;

    return;
}
use Test::More;

is( get_abcdrian_pangram(),
    'a ad added adds ado adobe adore adorn adverb adversaries adversary adversely adversest advertisement advertising advice aerospace aesthetic afar affix affluence afterward agonize ajar akin antiquate'
);

done_testing;

1;
