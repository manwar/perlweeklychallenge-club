      * Perl/Raku Weekly Challenge Week 257, Challenge 1
      *
      * GnuCOBOL, v 3.2-rc2.0
      *
      * Compile and execute with: $ cobc -xj ch-1.cob
      *
      * This code has the following brewed-in limitations:
      * - The system will randomly generate exactly five test arrays
      *   of exactly five positive integers each, in the range
      *   1-99.
      *
       IDENTIFICATION DIVISION.
         PROGRAM-ID. PRC-257-1.

       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 EXAMPLE-DATA.
           03 EXAMPLE-ARR OCCURS 5 TIMES.
             05 EXAMPLE-INT OCCURS 5 TIMES PIC 9(2) USAGE IS COMP.
         01 IDX1 PIC 9(1) USAGE IS COMP.
         01 IDX2 PIC 9(1) USAGE IS COMP.
         01 IDX3 PIC 9(1) USAGE IS COMP.
         01 COUNTER PIC 9(1) USAGE IS COMP.
         01 HEADER-LINE PIC X(40) VALUE ALL '-'.

       PROCEDURE DIVISION.
           PERFORM INITIALIZE_ONE_ARRAY VARYING IDX1 FROM 1 BY 1
             UNTIL IDX1 > 5.
           PERFORM ANALYZE_ONE_ARRAY VARYING IDX1 FROM 1 BY 1
             UNTIL IDX1 > 5.
           STOP RUN.

         ANALYZE_ONE_ARRAY.
           PERFORM DISPLAY_THIS_ARRAY.
           PERFORM VARYING IDX2 FROM 1 BY 1 UNTIL IDX2 > 5
             MOVE ZERO TO COUNTER
             PERFORM VARYING IDX3 FROM 1 BY 1 UNTIL IDX3 > 5
               IF IDX2 IS NOT = IDX3
                  AND EXAMPLE-INT(IDX1,IDX3) < EXAMPLE-INT(IDX1,IDX2)
                 ADD 1 TO COUNTER
               END-IF
             END-PERFORM
             DISPLAY EXAMPLE-INT(IDX1,IDX2) ': ' COUNTER
           END-PERFORM.
           EXIT.

         DISPLAY_THIS_ARRAY.
           DISPLAY HEADER-LINE.
           DISPLAY 'ARRAY #' IDX1 ':'.
           DISPLAY EXAMPLE-INT(IDX1, 1) ' ' EXAMPLE-INT(IDX1, 2)
             ' ' EXAMPLE-INT(IDX1, 3) ' ' EXAMPLE-INT(IDX1, 4)
             ' ' EXAMPLE-INT(IDX1, 5).
           EXIT.

         INITIALIZE_ONE_ARRAY.
           PERFORM VARYING IDX2 FROM 1 BY 1 UNTIL IDX2 > 5
             COMPUTE EXAMPLE-INT(IDX1,IDX2) = FUNCTION RANDOM * 99 + 1
           END-PERFORM.
           EXIT.
