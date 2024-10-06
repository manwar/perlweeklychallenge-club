#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
An Internet legend dating back to at least 2001 goes something like this:

    Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist and lsat ltteer be at the rghit pclae. The rset can be a toatl mses and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not raed ervey lteter by istlef, but the wrod as a wlohe.

This supposed Cambridge research is unfortunately an urban legend. However, the effect has been studied. For example—and with a title that probably made the journal's editor a little nervous—Raeding wrods with jubmled lettres: there is a cost by Rayner, White, et. al. looked at reading speed and comprehension of jumbled text.

Your task is to write a program that takes English text as its input and outputs a jumbled version as follows:

    The first and last letter of every word must stay the same
    The remaining letters in the word are scrambled in a random order (if that happens to be the original order, that is OK).
    Whitespace, punctuation, and capitalization must stay the same
    The order of words does not change, only the letters inside the word

So, for example, "Perl" could become "Prel", or stay as "Perl," but it could not become "Pelr" or "lreP".

I don't know if this effect has been studied in other languages besides English, but please consider sharing your results if you try!
=cut


use List::Util qw(shuffle);

print modify_text('Perl Weekly Challenge');


sub modify_text
{
     my $text = $_[0];
     $text =~ s/\b(\w+)\b/jumble($1)/ge;
     return $text;
}

sub jumble
{
     my $str = $_[0];
     my @arr = split(//, $str);
     @arr = ($arr[0], shuffle(@arr[1..$#arr - 1]), $arr[$#arr]);
     return join('', @arr);
}