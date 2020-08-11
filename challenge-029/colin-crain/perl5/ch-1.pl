#! /opt/local/bin/perl
#
#       brace_expansion.pl
#
#       29 Task #1:
#           Write a script to demonstrate brace expansion. For example, script would take
#           command line argument Perl {Daily,Weekly,Monthly,Yearly} Challenge and should
#           expand it and print like below:
#
#            Perl Daily Challenge
#
#            Perl Weekly Challenge
#
#            Perl Monthly Challenge
#
#            Perl Yearly Challenge
#
#       method: this seems like a job for a regex. Although not specified, let's make
#           it recursive, to accommodate multiple bracketed blocks. Nesting braces,
#           on the other hand, make no sense, won't parse right and need to be
#           escaped to avoid unexpected results. Both inside and outside the block
#           whitespace is preserved. The expanded text is inserted as is without
#           additional spacing. Originally I had allowed whitespace inside the block
#           for readability, which was ignored on rendering, but removed this to
#           maximize flexability in inserting text fragments. Escaped brackets are
#           ignored by the parser and passed through unchanged.
#
#       results:
#           $  ./brace_expansion.pl "Perl{ista's,esque,ite,escent, One Knit Two} {Daily,Weekly,Monthly,Yearly} Challenge"
#           Perlista's Daily Challenge
#           Perlista's Weekly Challenge
#           Perlista's Monthly Challenge
#           Perlista's Yearly Challenge
#           Perlesque Daily Challenge
#           Perlesque Weekly Challenge
#           Perlesque Monthly Challenge
#           Perlesque Yearly Challenge
#           Perlite Daily Challenge
#           Perlite Weekly Challenge
#           Perlite Monthly Challenge
#           Perlite Yearly Challenge
#           Perlescent Daily Challenge
#           Perlescent Weekly Challenge
#           Perlescent Monthly Challenge
#           Perlescent Yearly Challenge
#           Perl One Knit Two Daily Challenge
#           Perl One Knit Two Weekly Challenge
#           Perl One Knit Two Monthly Challenge
#           Perl One Knit Two Yearly Challenge
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $input = shift @ARGV;

my @output = expand_braces($input);

say  (join "\n", @output);

## ## ## ## ## SUBS

sub expand_braces {
    my $input = shift;
    my @expanded;

    if  ( $input =~ m/ ^(.*?)           ## group 1: from the beginning, whatever was before the brackets, minimally matched
                        (?<!\\)\{       ## a left bracket not preceeded by a backslash
                        (.*?)           ## group 2: the bracketed text list, minimally matched
                        (?<!\\)\}       ## a right bracket not preceeded by a backslash
                        (.*?)$ /x ) {   ## group 3: whatever is left until the end, minimally matched
        my $pre  = $1;
        my $post = $3;
        my @wordlist = split /,/, $2;

        ## insert the word and recursively build an expanded array
        for my $word ( @wordlist ){
            push @expanded, expand_braces("$pre$word$post");
        }
        return @expanded;
    }
    else {
    ## if no match pass the input right back out
        return $input;
    }
}
