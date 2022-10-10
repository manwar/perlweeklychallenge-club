#!/usr/bin/perl

use strict;
use warnings;
use English;

# Make sure UTF-8 is handled correctly
use utf8;
use open ":std", ":encoding(UTF-8)";

# This you'll need to install from CPAN
use Text::Unidecode;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "ÃÊÍÒÙ",
    "âÊíÒÙ",

    # Additional test cases
    "北亰",
    "χρονος"
);

print("\n");
foreach my $str (@strings){
    printf(
        "Input: \$str = '%s';\nOutput: '%s'\n\n",
        $str,
        # From Text::Unidecode; for once I'm going to
        # be lazy and just use a CPAN module
        unidecode($str)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



