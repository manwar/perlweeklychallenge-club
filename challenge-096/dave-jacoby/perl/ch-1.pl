#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

# I suppose I'm commenting instead of blogging, or pre-blogging, 
# but the key questions with this challenge are:
#   * "What is a word?"
#   * "What is a word boundary?"

# Mohammad gives us an easy one with "The Weekly Challenge", 
# where we can easily split on spaces and reverse, but padding
# spaces at the front and end of the next example make things harder.
# I mean, we COULD just use a regular expression to pull out the 
# begining and ending spaces, but splitting on /\s/ (space characters) 
# and grepping for /\S/ (non-space characters would be OK)

# but a space character isn't a word boundary. I asked and brian d foy
# gave me good advice about word boundaries. I mean, I asked the Internet
# and found his blog post:
#   https://www.effectiveperlprogramming.com/2016/06/perl-v5-22-adds-fancy-unicode-word-boundaries/

# I threw in the line from Buffalo Springfield's "For What It's Worth"
# because it adds an apostrophe, which confounds the pre-5.22 default 
# word border separation.

my @inputs;
push @inputs, 'The Weekly Challenge';
push @inputs, '    Perl and   Raku are  part of the same family  ';
push @inputs, q{Nobody's right if everybody's wrong};

for my $s (@inputs) {
    my $r = reverse_words($s);
    say <<"END";
    Input:  "$s"
    Output: "$r"
END
}

# This is a very pipe-y, very Dave way of doing this. Beyond the
# sub signature, I split on word boundaries as the blog suggests, 
# grep to make sure that there's something non-space, revers and 
# join with a space. I am sure a confounding string can be created
# but I'll engage that when the challenge is presented.
sub reverse_words ( $string ) {
    return join ' ', reverse grep /\S/, split /\b{wb}/, $string;
}
