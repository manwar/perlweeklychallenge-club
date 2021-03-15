#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vara /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <from> <to>
  
    <from>    string to convert from
    <to>      string to convert to
-USAGE-
    exit 0;
}

sub min {
    return (sort { $a <=> $b } @_)[0];
}

sub levenshtein {
    my ($from, $to) = @_;
    my $fromLength = length $from;
    my $toLength = length $to;

    if ($toLength == 0) {
        return $fromLength;
    }
 
    if ($fromLength == 0) {
        return $toLength;
    }

    my $fromTail = substr($from, 1, $fromLength - 1);
    my $toTail = substr($to, 1, $toLength - 1);

    if (substr($from, 0, 1) eq substr($to, 0, 1)) {
        return levenshtein($fromTail, $toTail);
    }

    return 1 + min(
        levenshtein($from, $toTail), # Insert
        levenshtein($fromTail, $to), # Remove
        levenshtein($fromTail, $toTail) # Replace
    );
}

if (scalar @ARGV < 2) {
    usage();
}

say levenshtein($ARGV[0], $ARGV[1]);
