#!/usr/env/perl
# Task 1 Challenge 063 Solution by saiftynet
# Last Word Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
# Define sub last_word($string, $regexp) that returns the last word matching 
# $regexp found in the given string, or undef if the string does 
# not contain a word matching $regexp.
# For this challenge, a &ldquo;word&rdquo; is defined as any character 
# sequence consisting of non-whitespace characters (\S) only. That 
# means punctuation and other symbols are part of the word.
# The $regexp is a regular expression. Take care that the regexp 
# can only match individual words! 


# Description says it all... consider word boundary to be \s
# so split on /\s+/, reverse it so that the last is now first
# then match each against the offered regexp.  The regexp may
# be passed eaither as string or as qr/<regexp>/


use v5.14;
say last_word('  hello world',                "[ea]l");        # 'hello'
say last_word("Don't match too much, Chet!",  qr/ch.t/i);      # 'Chet!'
say last_word("spaces in regexp won't match", qr/in re/);      #  undef
say last_word( join(' ', 1..1e6),             qr/^(3.*?){3}/); # '399933'

sub last_word{
  my ($str,$regExp)=@_;
  $regExp=qr/$regExp/ unless (ref $regExp =~/Regexp/);
  foreach my $word (reverse split /\s+/, $str){
    return $word if $word=~m/$regExp/
  } 
}

