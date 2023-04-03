#!/usr/bin/perl

# Challenge 014
#
# Challenge #2
# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell? Here
# is the list of U.S. states abbreviations as per wikipedia page. This challenge
# was proposed by team member Neil Bowers.
#
# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari

use Modern::Perl;

my %us_states = (
    AL => 'Alabama',
    AK => 'Alaska',
    AZ => 'Arizona',
    AR => 'Arkansas',
    CA => 'California',
    CO => 'Colorado',
    CT => 'Connecticut',
    DE => 'Delaware',
    FL => 'Florida',
    GA => 'Georgia',
    HI => 'Hawaii',
    ID => 'Idaho',
    IL => 'Illinois',
    IN => 'Indiana',
    IA => 'Iowa',
    KS => 'Kansas',
    KY => 'Kentucky',
    LA => 'Louisiana',
    ME => 'Maine',
    MD => 'Maryland',
    MA => 'Massachusetts',
    MI => 'Michigan',
    MN => 'Minnesota',
    MS => 'Mississippi',
    MO => 'Missouri',
    MT => 'Montana',
    NE => 'Nebraska',
    NV => 'Nevada',
    NH => 'New Hampshire',
    NJ => 'New Jersey',
    NM => 'New Mexico',
    NY => 'New York',
    NC => 'North Carolina',
    ND => 'North Dakota',
    OH => 'Ohio',
    OK => 'Oklahoma',
    OR => 'Oregon',
    PA => 'Pennsylvania',
    RI => 'Rhode Island',
    SC => 'South Carolina',
    SD => 'South Dakota',
    TN => 'Tennessee',
    TX => 'Texas',
    UT => 'Utah',
    VT => 'Vermont',
    VA => 'Virginia',
    WA => 'Washington',
    WV => 'West Virginia',
    WI => 'Wisconsin',
    WY => 'Wyoming',
);

my @codes = keys %us_states;            # all states two letter codes
my $codes = join("|", @codes);          # regex to match any codes
my $regex = qr/^($codes)+$/i;           # regex to match word composed of codes

# find all words that match, save longest ones
@ARGV==1 or die "usage: ch-2.pl dictionary.txt\n";
my $words = shift;

my @longest;
open(my $fh, "<", $words) or die "open $words: $!\n";
while (<$fh>) {
    chomp;
    next unless /$regex/;               # filter words that match state codes
    if (!@longest || length($_) > length($longest[0])) {
        @longest = ($_);
    }
    elsif (length($_) == length($longest[0])) {
        push @longest, $_;
    }
}

# show longest words in form: word = state + state + ...
for my $word (@longest) {
    my @states = map {$_ = $us_states{uc($_)}} grep {$_} split /(..)/, $word;
    say $word, " = ", join(" + ", @states);
}
