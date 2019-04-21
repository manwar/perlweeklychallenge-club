#! /usr/bin/perl


#Here's a little hacky way of doing this: I'm encoding the digits
#of pi in unicode characters, and then turning them back into
#digits. I get between 4 and 5 digits per chinese character (or
#math symbol). It's a bit golfy, b/c I'm assuming whitespace
#counts towards the 'length' of the script. I'm counting 'length'
#by characters, not by bytes.
use utf8;print for'3.',map ord,split//,'㝏枧⌓纀閷┞⊉◴Ⓑ銆:'

#this is just so I can put both in the same script
;
#I assume that printing via die counts too, because print makes
#this too long.
#Arctan of 1 is actually defined as pi/4, and I get 15 digits
#precision on my box (64 bit Ubuntu Xenial)
die 4*atan2 1,1
