#!/usr/bin/bf

[
# Challenge 001
#
# Challenge #2
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the word
# ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both
# divisible by 3 and 5 become ‘fizzbuzz’.
]

>++++[<+++++>-]<                # Tape: *counter=20
>+                              # Tape: counter *index=1
<                               # Tape: *counter index
[                               # WHILE counter
                                # Tape: *counter index found_branch

                                # MOVE index
    >[->>+>+<<<]                # Tape: counter *0 found index index
    >>>[-<<<+>>>]<              # Tape: counter index found *index

                                # DIVIDE by 3
    >>>>+++<<<<                 # Tape: counter index found *index 0 0 0 3
    [->+>>+>-[<-]<[<<[->>>+<<<]>>>>+<<-<]<<]    # divide
                                # Tape: 0 R 0 0 B' Q
    >>>>[-]>[-]<<<<             # cleanup all but R  cursor on R
    >>+<[-<->]<[[-]>>-<<]>>[<<+>>-]<<   # check if R==0
                                # Tape: counter index found 0 *divisible
    [                           # IF divisible by 3
        <<+                     # Tape: counter index *inc_found
        >
        [-]>[-]<
        >++++++++++[<++++++++++>-]<++.  # "f" tape=102
        +++.                            # "i" tape=105
        >+++[<++++++>-]<-..             # "zz" tape=122
        [-]

        >
        [-]
    ]                           # END IF

    <<<                         # MOVE index
    [->>+>+<<<]                 # Tape: counter *0 found index index
    >>>[-<<<+>>>]<              # Tape: counter index found *index

                                # DIVIDE by 5
    >>>>+++++<<<<               # Tape: counter index found *index 0 0 0 5
    [->+>>+>-[<-]<[<<[->>>+<<<]>>>>+<<-<]<<]    # divide
                                # Tape: 0 R 0 0 B' Q
    >>>>[-]>[-]<<<<             # cleanup all but R  cursor on R
    >>+<[-<->]<[[-]>>-<<]>>[<<+>>-]<<   # check if R==0
                                # Tape: counter index found 0 *divisible
    [                           # IF divisible by 5
        <<+                     # Tape: counter index *inc_found
        >

        [-]>[-]<
        >++++++++++[<++++++++++>-]<--.  # "b" tape=98
        >++++[<+++++>-]<-.              # "u" tape=117
        +++++..                         # "zz" tape=122
        [-]

        >
        [-]
    ]                           # END IF

    <<                          # Tape: counter index *found
    >>+<[-<->]<[[-]>>-<<]>>[<<+>>-]<<   # check if found==0
    [                           # IF not yet found

        <                       # MOVE index
        [->>>+>+<<<<]           # Tape: counter *0 found 0 index index
        >>>>[-<<<<+>>>>]<       # Tape: counter index found 0 *index

                                # PRINT NUMBER tape= 0 *M 0 0 0
        [>>>>++++++++++<<<<[->+>>+>-[<-]<[<<[->>>+<<<]>>>>+<<-<]<<]
        ++++++++[->++++++<]>[-<+>]>>>>[-<<<<+>>>>]<[-]<<<]<[.<]

        >[-]>[-]>[-]>[-]<<<<    # clear digits
        <
        [-]
    ]                           # ENDIF

    [-]++++++++++.[-]           # newline tape=0

    <<                          # Tape: *counter index found

    >+<-                        # Tape: *dec_counter inc_index
]                               # END WHILE counter
