#!/usr/bin/env perl6

#| Print the longest word in the given <dict> that can be spelt with only the
#| ANSI abbreviations of US states.
unit sub MAIN (
  $dict = '/usr/share/dict/words' #= Dictionary of words; defaults to
				  #= /usr/share/dict/words.
);

my %states = <AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA
              MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX
              UT VT VA WA WV WI WY> Z=> ('Alabama', 'Alaska', 'Arizona',
              'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware',
              'District of Columbia', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
              'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
              'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
              'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
              'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
              'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon',
              'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
              'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
              'West Virginia', 'Wisconsin', 'Wyoming');

my $states = set %states.keys;

my @words = $dict.IO.words\
                 .grep({.chars ≥ 4 && .chars %% 2})».uc\
		 .unique.sort(*.chars <=> *.chars).reverse;

given @words.first(*.comb(2) ⊂ $states) {
  say %states{.comb(2)}.join(' + ') ~ ' = ' ~ $_;
}
