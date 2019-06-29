# Using only the official postal (2-letter) abbreviations for the 50 U.S. states,
# write a script to find the longest English word you can spell?
# Here is the list of U.S. states abbreviations as per wikipedia page.
# This challenge was proposed by team member Neil Bowers.

# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari

use strict;
use warnings;
use v5.10;

# We will use list of 50 US states from http://www.softschools.com/social_studies/state_abbreviations/
# pasted after __DATA__

my %states;
/(\w.+)\t(\w{2})$/, $states{$2} = $1 for <DATA>;

# now the keys of %states hash are the 2 letter codes of all 50 states
# we follow by noting that if we construct a regexp like:
# /^(AL|AK|AZ .... |WY)+$/
# it will only match words composed by some combination of the two letter codes
# and that is exactly what the challenge asks

my $qrstring = '^(' . join( '|', keys %states ) . ')+$';
my $test_qr = qr/$qrstring/i;

# we also need a word list to check against.
# we will use '/usr/share/dict/words'
# or the one user provides

my $words_file = shift // '/usr/share/dict/words';

open my $f, $words_file or die "Usage: perl $0 <path to words list file>";

my $long_word = '';

# we just read word by word our dictionary, and check if we have a longer
# match against the constructed regexp
while ( my $w = <$f> ) {
    chomp $w;
    $long_word = $w if length($w) > length($long_word) && $w =~ $test_qr;
}

# and that's it, we should have longest match already on $long_word
say $long_word;

__DATA__
  ALABAMA	AL
  ALASKA	AK
  ARIZONA	AZ
  ARKANSAS	AR
  CALIFORNIA	CA
  COLORADO	CO
  CONNECTICUT	CT
  DELAWARE	DE
  FLORIDA	FL
  GEORGIA	GA
  HAWAII	HI
  IDAHO	ID
  ILLINOIS	IL
  INDIANA	IN
  IOWA	IA
  KANSAS	KS
  KENTUCKY	KY
  LOUISIANA	LA
  MAINE	ME
  MARYLAND	MD
  MASSACHUSETTS	MA
  MICHIGAN	MI
  MINNESOTA	MN
  MISSISSIPPI	MS
  MISSOURI	MO
  MONTANA	MT
  NEBRASKA	NE
  NEVADA	NV
  NEW HAMPSHIRE	NH
  NEW JERSEY	NJ
  NEW MEXICO	NM
  NEW YORK	NY
  NORTH CAROLINA	NC
  NORTH DAKOTA	ND
  OHIO	OH
  OKLAHOMA	OK
  OREGON	OR
  PENNSYLVANIA	PA
  RHODE ISLAND	RI
  SOUTH CAROLINA	SC
  SOUTH DAKOTA	SD
  TENNESSEE	TN
  TEXAS	TX
  UTAH	UT
  VERMONT	VT
  VIRGINIA	VA
  WASHINGTON	WA
  WEST VIRGINIA	WV
  WISCONSIN	WI
  WYOMING	WY
