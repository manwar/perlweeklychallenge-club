#!/bin/sh
perl -nle 'if (/0[^1]|1[^02]|2[^13]|3[^24]|4[^35]|5[^46]|6[^57]|7[^68]|8[^79]|9[^8]/) {$a=$_;s/$&/[$&]/;print "$a is *not* an esthetic number ($_)"} else {print "$_ is an esthetic number" }'


#echo -e "123\n120\n5456\n987678\n123321" | perl -nle 'if (/0[^1]|1[^02]|2[^13]|3[^24]|4[^35]|5[^46]|6[^57]|7[^68]|8[^79]|9[^8]/) {$a=$_;s/$&/[$&]/;print "$a is *not* an esthetic number ($_)"} else {print "$_ is an esthetic number" }'
#123 is an esthetic number
#120 is *not* an esthetic number (1[20])
#5456 is an esthetic number
#987678 is an esthetic number
#123321 is *not* an esthetic number (12[33]21)
