use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-10-03
# Challenge 185 Mask Code ( Raku )

my @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy', '1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');

for ( @list ) -> $code {

  my $cnt = 0;                    # where we are in the string

  my $fnd = 0;                    # count of characters changed

  my @arr = split(/''/, $code);   # change string to an array entry

  while $fnd < 4  {             # looking for 4 chars that are alpha numeric

    if @arr[$cnt] ~~ /\w/ {     # if character is alpha or numeric

      @arr[$cnt] = 'x';         # change it to an 'x'

      $fnd++;                   # and bump the fnd counter

    }

    $cnt++;                     # bump our char position

  }

  my $str = join('',@arr);      # join array chars back to a string

  say $str;                     # and print it

}
