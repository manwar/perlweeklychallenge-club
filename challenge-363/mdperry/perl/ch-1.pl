#!/usr/bin/env perl

use v5.38;
use utf8;
use open ':std', ':encoding(UTF-8)';

=head1 COMMENTS

 Task 1: String Lie Detector

 You are given a string.

 Write a script that parses a self-referential string and determines whether
 its claims about itself are true.   The string will make statements about its
 own composition, specifically the number of vowels and consonants it contains.

=cut

my %examples = ( Example_1 => "aa — two vowels and zero consonants",
                 Example_2 => "iv — one vowel and one consonant",
	         Example_3 => "hello - three vowels and two consonants",
  	         Example_4 => "aeiou — five vowels and zero consonants",
		 Example_5 => "aei — three vowels and zero consonants"
	       );

# I decided to provide my own hash to map the numerals to their English
# language equivalents
my %numbers = ( 0 => 'zero',
		1 => 'one',
		2 => 'two',
		3 => 'three',
		4 => 'four',
		5 => 'five',
		6 => 'six',
		7 => 'seven',
		8 => 'eight',
		9 => 'nine',
	      );


foreach my $example ( sort keys %examples ) {
    # Not clear to me if this was deliberate (vs. unintentional copy-paste) but
    # most examples actually have em-dashes, but one has just a hyphen, so I had to
    # get slightly more sophisticated than I anticipated with my regex for this step
    # But this is EXCELLENT practice for real life data munging & data wrangling
    my ( $string, $fact, ) = split(/\s+(?:\x{2014}|-)\s+/, $examples{$example});
    my $status = q{};
    # Yadda-yadda-yadda, is there an O'Reilly book on the Perl Programming Language that
    # does NOT have this example of how to turn a string into an array of it's
    # substituent characters?
    my @letters = split(//, $string);
    # I want to count the number of vowels in the first string, and evaluating this statement
    # in a scalar context will give me that number
    my $vowels = grep { /[aeiou]/ } @letters;
    my $consonants = length($string) - $vowels;
    # Caveat emptor: some of the examples have a singular vowel, whilst others
    # have plural vowels
    my ( $v_fact, $c_fact ) = $fact =~ m/(.+) vowels? and (.+) consonant/;
    if ( $numbers{$vowels} eq $v_fact and $numbers{$consonants} eq $c_fact ) {
	$status = 'true';
    }
    else {
	$status = 'false';
    }
    
    print "$example\n";
    print "Input: \"", $examples{$example}, "\"\n";
    print "Output: ", $status, "\n\n";
}

__END__

OUTPUT from running this Script:

Example_1
Input: "aa — two vowels and zero consonants"
Output: true

Example_2
Input: "iv — one vowel and one consonant"
Output: true

Example_3
Input: "hello - three vowels and two consonants"
Output: false

Example_4
Input: "aeiou — five vowels and zero consonants"
Output: true

Example_5
Input: "aei — three vowels and zero consonants"
Output: true
    
