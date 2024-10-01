use strict; use warnings; use List::Util 'shuffle'; use v5.26;

sub jumbled_letters {
    pop =~ s{
      \b             #border between a \w and a non-\w
      ([a-z])        #first letter in a word, upper or lower case due to /i
      ([a-z]+)       #middle part of a word, at least one letter
      ([a-z])        #last letter
      \b
    }{
      $1
      . join('', shuffle split'', $2)
      . $3
    }geirx
}

my $text = @ARGV ? "@ARGV" : <<~'🛑';
    Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t
    mttaer in waht oredr the ltteers in a wrod are, the olny iprmoetnt
    tihng is taht the frist and lsat ltteer be at the rghit pclae. The
    rset can be a toatl mses and you can sitll raed it wouthit
    porbelm. Tihs is bcuseae the huamn mnid deos not raed ervey lteter
    by istlef, but the wrod as a wlohe.
    🛑

print jumbled_letters($text);
