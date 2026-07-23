#! /usr/bin/env raku

subset HEX2 where * ~~ /^ <[0 .. 9 A .. F]> ** 2 $/;

unit sub MAIN ($color where $color ~~ /^ "#" <[0 .. 9 A .. F]> ** 6 $/,
               :v(:$verbose));

sub nearest-hex (HEX2 $hex)
{
  my $decimal = $hex.parse-base(16);

  say ":Hex $hex = Decimal $decimal" if $verbose;

  return '00' if $decimal <=  25; #   0
  return '33' if $decimal <=  76; #  51
  return '66' if $decimal <= 127; # 102
  return '99' if $decimal <= 178; # 153
  return 'CC' if $decimal <= 229; # 204
  return 'FF';                    # 255
}

say "#"
  ~ nearest-hex($color.substr(1,2))
  ~ nearest-hex($color.substr(3,2))
  ~ nearest-hex($color.substr(5,2));
