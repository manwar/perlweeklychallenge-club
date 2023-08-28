#!//bin/sh

perl -E '@a=sort{$a<=>$b}@ARGV;$min=$a[0];$max=$a[-1];$_=join q{, },grep{$_!=$min&&$_!=$max}@ARGV;say length?$_:-1' "$@"