#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub readText {
    my ($filename) = @_;
    my $text;
 
    open my $fh, '<', $filename or die "$OS_ERROR\n";
    local $RS = undef;
    $text = <$fh>;
    close $fh;
 
    return $text;
}

sub removePunctuation {
    my ($text) = @_;

    $text =~ s/ \. | " | \( | \) | , | 's | --/ /gmsx;

    return $text;
}

sub countWords {
    my ($text) = @_;
    my %count;
    my @words = split /\s+/, $text;

    for my $word (@words) {
        $count{$word}++;
    }

    return \%count;
}

sub display {
    my ($count) = @_;
    my %frequency;

    map {push @{$frequency{$count->{$_}}}, $_; } sort keys %{$count};

    for my $key (sort keys %frequency) {
        say "$key ", (join q{ }, @{$frequency{$key}}), "\n";
    }
}

display(
    countWords(
        removePunctuation(
            readText(
                './input'
            )
        )
    )
);