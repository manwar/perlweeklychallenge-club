use strict;
use warnings;
use feature 'say';
use utf8;
use Unicode::UCD qw/charinfo charscript charinrange/;

my $LATIN_RANGE = charscript('Latin');

my @examples = qw/ÃÊÍÒÙ âÊíÒÙ ŒőŢų/;
for my $example (@examples) {
    say "$example: '" . makeover($example) . "'";
}

sub makeover {
    my ($str) = @_;
    my $str_makeover = '';
    for my $char ( split //, $str ) {
        $str_makeover .= unicode2asscii($char);
    }
    return $str_makeover;
}

sub unicode2asscii {
    my ($char) = @_;
    my $ord_num = ord($char);
    if ( !charinrange( $LATIN_RANGE, $ord_num ) ) {
        return $char;
    }
    my $char_info = charinfo($ord_num);
    my $out_char  = $char;
    if ( $char_info->{'name'} =~
        /^LATIN (CAPITAL|SMALL) (?:LETTER|LIGATURE) (?:[A-Z]+ )?([A-Z]{1,2})\b/
      )
    {
        $out_char = $1 eq 'SMALL' ? lc($2) : $2;
    }
    return $out_char;
}
