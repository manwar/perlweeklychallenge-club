perl -E 'say join " ", map {length($_)<=2 ? lc($_) : ucfirst(lc($_))} split / /, shift' "PERL IS gREAT"
perl -E 'say join " ", map {length()<=2 ? lc : ucfirst lc} split / /, shift' "PERL IS gREAT"
perl -E 'say join " ", map {length()<=2 ? lc : ucfirst lc} split / /, shift' "THE weekly challenge"
perl -E 'say join " ", map {length()<=2 ? lc : ucfirst lc} split / /, shift' "YoU ARE A stAR"
