v                     ,+55  < # Print newline, and restart
>00045*p145*p    v >$"1-",, ^ # Initialize max and sec // print "-1"
v_v#-+55: _@#+1:~<         <  # Read ch, terminate on EOF, branch on newline
  >145*g:!        #^_     , ^ # Fetch sec, if non-zero, print it,
        >       > $        ^  # Pop stack
>:"0"`!#^_:"9"`#^_v           # Branch if less than "0", or larger than "9"
v       _v#-g*540:<
         >                 ^  # If ch == max, don't do anything
>:045*g`!#v_045*g145*p045*p^  # If ch > max: sec = max; max = ch
v         <>         $     ^  # Pop stack
>:145*g`! #^_145*p         ^  # If ch > sec; sec = ch
