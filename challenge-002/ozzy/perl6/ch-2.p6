#!/usr/bin/env perl6                                                                                                                                                                 
# The obvious way to go is probably the use of Perl6' .base and .parse-base methods:

loop {

   my Str $a = prompt("\nPlease, give me a decimal (base-10) number : ");
   say("$a in decimal notation is { $a.Int.base(35) } in base-35 notation.");

   $a = prompt("\nNow give me a base-35 number [A-Y0-9]: ");
   say("$a in base-35 notation is { $a.parse-base(35) } in base-10 notation.")

 } 
