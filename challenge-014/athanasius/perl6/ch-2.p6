use v6;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my constant $TIMER = 1;

# Abbreviations according to the "USPS" (United States Postal Service) column of
# the Table in https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations

my constant %STATES_POSTAL =
(
    :AL('Alabama'),        :AK('Alaska'),        :AZ('Arizona'),
    :AR('Arkansas'),       :CA('California'),    :CO('Colorado'),
    :CT('Connecticut'),    :DE('Delaware'),      :FL('Florida'),
    :GA('Georgia'),        :HI('Hawaii'),        :ID('Idaho'),
    :IL('Illinois'),       :IN('Indiana'),       :IA('Iowa'),
    :KS('Kansas'),         :KY('Kentucky'),      :LA('Louisiana'),
    :ME('Maine'),          :MD('Maryland'),      :MA('Massachusetts'),
    :MI('Michigan'),       :MN('Minnesota'),     :MS('Mississippi'),
    :MO('Missouri'),       :MT('Montana'),       :NE('Nebraska'),
    :NV('Nevada'),         :NH('New Hampshire'), :NJ('New Jersey'),
    :NM('New Mexico'),     :NY('New York'),      :NC('North Carolina'),
    :ND('North Dakota'),   :OH('Ohio'),          :OK('Oklahoma'),
    :OR('Oregon'),         :PA('Pennsylvania'),  :RI('Rhode Island'),
    :SC('South Carolina'), :SD('South Dakota'),  :TN('Tennessee'),
    :TX('Texas'),          :UT('Utah'),          :VT('Vermont'),
    :VA('Virginia'),       :WA('Washington'),    :WV('West Virginia'),
    :WI('Wisconsin'),      :WY('Wyoming'),
);

my constant $STATES = Set[Str].new( %STATES_POSTAL.keys );

# Dictionary file downloaded from https://github.com/dwyl/english-words

my Str constant $WORDS_FILE = '../words_alpha.txt';

sub MAIN()
{
	my DateTime $t0 = DateTime.now if $TIMER;

    my (Int:D $total, Array:D $words) = get-words();

    say "\n$total words read from file '$WORDS_FILE', of which\n",
         sprintf('%*d', $total.chars, $words.elems),
        ' can be formed from US state abbreviations';

    if ($words.elems == 0)
    {
        say "\nNo solutions found";
    }
    else
    {
        my (Int:D $max-len, List:D $solutions) = get-solutions($words);

        say "\nThe longest of these ",
              "ha{ $solutions.elems == 1 ?? 's' !! 've' } $max-len letters:";

        for @$solutions -> Str:D $solution
        {
            my @states = ($solution ~~ m:g/../).map: { %STATES_POSTAL{.uc} };

            say $solution, ' = ', @states.join(' + ');
        }
    }

	if ($TIMER)
	{
		my DateTime $t = DateTime.now;
		say "\nTime elapsed: { $t - $t0 } seconds";
    }
}

sub get-words(--> List:D)
{
    my Int $total = 0;
    my     @words;

    WORD:
    for $WORDS_FILE.IO.lines -> Str $word
    {
        ++$total;

        next unless $word.chars % 2 == 0;

        for $word ~~ m:g/../ -> Match $pair
        {
            next WORD unless $pair.uc ∈ $STATES;
        }

        @words.push: $word;
    }

    return $total, @words;
}

sub get-solutions(Array:D $words --> List:D)
{
    my     @words   = $words.sort: { .chars };
    my Int $index   = @words.end;
    my Int $max-len = @words[ $index ].chars;

    Nil while @words[ --$index ].chars == $max-len;

    return $max-len, @words[ ++$index .. * ];
}

################################################################################
