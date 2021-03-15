#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (:f(:$file) where $file.IO.f && $file.IO.r = 'input.txt',
               PosInt :s($size)  = 4);

say ( readN($file, $size) || last ) for ^Inf;

sub readN ($FILE, $number)
{
  state %handle;
  
  %handle{$FILE} = $FILE.IO.open unless %handle{$FILE};

  return %handle{$FILE}.readchars($number);
}
