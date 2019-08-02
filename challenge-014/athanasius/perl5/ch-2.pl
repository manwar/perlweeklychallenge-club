#!perl

################################################################################
=comment

Perl Weekly Challenge 014
=========================

Challenge #2
------------

Using only the official postal (2-letter) abbreviations for the 50 U.S. states,
write a script to find the longest English word you can spell? Here is the list
of U.S. states abbreviations as per wikipedia
[ https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations |page]. This
challenge was proposed by team member *Neil Bowers*.

  For example,
  Pennsylvania + Connecticut = PACT
  Wisconsin + North Dakota = WIND
  Maine + Alabama = MEAL
  California + Louisiana + Massachusetts + Rhode Island = Calamari

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use utf8;
use warnings;
use Const::Fast;
use constant TIMER => 1;

# Abbreviations according to the "USPS" (United States Postal Service) column of
# the Table in https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations

const my %STATES_POSTAL =>
      (
          AL => 'Alabama',        AK => 'Alaska',        AZ => 'Arizona',
          AR => 'Arkansas',       CA => 'California',    CO => 'Colorado',
          CT => 'Connecticut',    DE => 'Delaware',      FL => 'Florida',
          GA => 'Georgia',        HI => 'Hawaii',        ID => 'Idaho',
          IL => 'Illinois',       IN => 'Indiana',       IA => 'Iowa',
          KS => 'Kansas',         KY => 'Kentucky',      LA => 'Louisiana',
          ME => 'Maine',          MD => 'Maryland',      MA => 'Massachusetts',
          MI => 'Michigan',       MN => 'Minnesota',     MS => 'Mississippi',
          MO => 'Missouri',       MT => 'Montana',       NE => 'Nebraska',
          NV => 'Nevada',         NH => 'New Hampshire', NJ => 'New Jersey',
          NM => 'New Mexico',     NY => 'New York',      NC => 'North Carolina',
          ND => 'North Dakota',   OH => 'Ohio',          OK => 'Oklahoma',
          OR => 'Oregon',         PA => 'Pennsylvania',  RI => 'Rhode Island',
          SC => 'South Carolina', SD => 'South Dakota',  TN => 'Tennessee',
          TX => 'Texas',          UT => 'Utah',          VT => 'Vermont',
          VA => 'Virginia',       WA => 'Washington',    WV => 'West Virginia',
          WI => 'Wisconsin',      WY => 'Wyoming',
      );

# Regular expression to match (case-insensitively, but otherwise exactly) any
# one of the 50 state postal abbreviations

const my $STATES_REGEX =>
          eval 'qr/^(?:' . join('|', keys %STATES_POSTAL) . ')$/i';

# Dictionary file downloaded from https://github.com/dwyl/english-words

const my $WORDS_FILE => '../words_alpha.txt';

$| = 1;

MAIN:
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );
    my  $t0 = [gettimeofday] if TIMER;
    my ($total, $words) = get_words();

    printf "\n%d words read from file '$WORDS_FILE', of which\n" .
             "%6d can be formed from US state abbreviations\n",
              $total, scalar @$words;

    if (scalar @$words == 0)
    {
        print "\nNo solutions found\n";
    }
    else
    {
        my $solutions = get_solutions($words);

        printf "\nThe longest of these ha%s %d letters:\n",
               (scalar @$solutions == 1) ? 's' : 've', length $solutions->[0];

        for my $solution (@$solutions)
        {
            my @states = map { $STATES_POSTAL{uc $_} } $solution =~ /../g;

            printf "%s = %s\n", $solution, join(' + ', @states);
        }
    }

    my $t = tv_interval($t0)     if TIMER;
    print "\n", $t, " seconds\n" if TIMER;
}

sub get_words
{
    my $total = 0;
    my @words;

    open my $fh, '<', $WORDS_FILE
        or die "Cannot open file '$WORDS_FILE' for reading, stopped";

    WORD:
    while (my $word = <$fh>)
    {
        ++$total;
        chomp $word;
        next unless length($word) % 2 == 0;

        for my $pair ($word =~ /../g)
        {
            next WORD unless $pair =~ $STATES_REGEX;
        }

        push @words, $word;
    }

    close $fh
        or die "Cannot close file '$WORDS_FILE', stopped";

    return ($total, \@words);
}

sub get_solutions
{
    my ($words)  = @_;
       @$words   = sort { length $b <=> length $a } @$words;        # Descending
    my  $index   = 0;
    my  $max_len = length $words->[$index];

    1 while length $words->[++$index] == $max_len;

    return [ @$words[0 .. --$index] ];      # Alternative syntax: $words->@[...]
}

################################################################################
