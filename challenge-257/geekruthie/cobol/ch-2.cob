      * Perl/Raku Weekly Challenge Week 257, Challenge 2
      *
      * GnuCOBOL, v 3.2-rc2.0
      *
      * Compile and execute with: $ cobc -xj ch-2.cob
      *
      * This code has the following brewed-in limitations:
      *  - Exactly six matrices will be read in.
      *  - The maximum matrix size is 5x5 signed integers.
      *  - The data file must be organized properly, or
      *    chaos and madness will result.

       IDENTIFICATION DIVISION.
         PROGRAM-ID. PRC-257-2.
       ENVIRONMENT DIVISION.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
           SELECT TEST-DATA
           ASSIGN TO 'ch-2.dat'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
         FILE SECTION.
         FD TEST-DATA.
         01 DATA-REC PIC X(80).
         WORKING-STORAGE SECTION.
         01 DIMENSION_DATA OCCURS 6 TIMES.
           03 DIM-X PIC 9(2) USAGE IS COMP.
           03 DIM-Y PIC 9(2) USAGE IS COMP.
         01 EXAMPLE-DATA.
           03 EXAMPLE-MATRIX OCCURS 6 TIMES.
             05 ROW-DATA OCCURS 5 TIMES.
               07 COLUMN-DATA OCCURS 5 TIMES.
                 09 CELL PIC S9(2) USAGE IS COMP.
         01 IDX1 PIC 9(1) USAGE IS COMP.
         01 IDX2 PIC 9(1) USAGE IS COMP.
         01 IDX3 PIC 9(1) USAGE IS COMP.
         01 LEADING-1 PIC 9(1) OCCURS 5 TIMES.
         01 FILLER PIC X(1) VALUE 'N'.
           88 ZERO-ROW-NOT-FOUND VALUE 'N'.
           88 ZERO-ROW-FOUND VALUE 'Y'.
         01 FILLER PIC X(1) VALUE 'N'.
           88 IS-NOT-RRE VALUE 'N'.
           88 IS-RRE VALUE 'Y'.
         01 FILLER PIC X(1) VALUE 'N'.
           88 ROW-NOT-CHECKED VALUE 'N'.
           88 ROW-CHECKED VALUE 'Y'.
         01 HEADER-LINE PIC X(40) VALUE ALL '-'.

       PROCEDURE DIVISION.
           OPEN INPUT TEST-DATA.
           PERFORM READ-MATRICES-FROM-FILE VARYING IDX1 FROM 1 BY 1
             UNTIL IDX1 > 6.
           CLOSE TEST-DATA.
           PERFORM DISPLAY-MATRIX VARYING IDX1 FROM 1 BY 1
             UNTIL IDX1 > 6.
           STOP RUN.

         ANALYZE-MATRIX.
           SET IS-RRE TO TRUE;
           PERFORM VARYING IDX2 FROM 1 BY 1 UNTIL IDX2 > 5
             INITIALIZE LEADING-1(IDX2)
           END-PERFORM.
           PERFORM RULE-1 VARYING IDX2 FROM 1 BY 1
             UNTIL IDX2 > DIM-Y(IDX1) OR IS-NOT-RRE.
           SET ZERO-ROW-NOT-FOUND TO TRUE.
           PERFORM RULE-2 VARYING IDX2 FROM 1 BY 1
             UNTIL IDX2 > DIM-Y(IDX1) OR IS-NOT-RRE.
           PERFORM RULE-3 VARYING IDX2 FROM 1 BY 1
             UNTIL IDX2 > DIM-Y(IDX1) OR IS-NOT-RRE.
           PERFORM RULE-4 VARYING IDX2 FROM 1 BY 1
             UNTIL IDX2 > DIM-Y(IDX1) OR IS-NOT-RRE.
           IF (IS-RRE)
             DISPLAY "This matrix is RRE."
           ELSE
             DISPLAY "This matrix is NOT RRE."
           EXIT.

         DISPLAY-MATRIX.
           DISPLAY HEADER-LINE.
           DISPLAY 'MATRIX #' IDX1.
           PERFORM VARYING IDX2 FROM 1 BY 1 UNTIL IDX2 > DIM-Y(IDX1)
             PERFORM VARYING IDX3 FROM 1 BY 1 UNTIL IDX3 > DIM-X(IDX1)
               DISPLAY CELL(IDX1,IDX2,IDX3) ' ' WITH NO ADVANCING
             END-PERFORM
             DISPLAY ' '
           END-PERFORM.
           PERFORM ANALYZE-MATRIX.
           EXIT.

         READ-MATRICES-FROM-FILE.
           READ TEST-DATA.
           UNSTRING DATA-REC
             DELIMITED BY SPACES
             INTO DIM-X(IDX1)
                  DIM-Y(IDX1).
             PERFORM READ-MATRIX-ROW VARYING IDX2 FROM 1 BY 1
               UNTIL IDX2 > DIM-Y(IDX1).
           EXIT.

         READ-MATRIX-ROW.
           READ TEST-DATA.
           UNSTRING DATA-REC
             DELIMITED BY SPACES
             INTO CELL(IDX1, IDX2, 1)
                  CELL(IDX1, IDX2, 2)
                  CELL(IDX1, IDX2, 3)
                  CELL(IDX1, IDX2, 4)
                  CELL(IDX1, IDX2, 5).
           EXIT.

      * If a row does not consist entirely of zeros, then the first
      * nonzero number in the row is a 1. We call this the leading 1.
         RULE-1.
           SET ROW-NOT-CHECKED TO TRUE.
           PERFORM VARYING IDX3 FROM 1 BY 1
              UNTIL IDX3 > DIM-X(IDX1) OR ROW-CHECKED OR IS-NOT-RRE
              IF ( CELL(IDX1, IDX2, IDX3) IS NOT ZERO)
                IF ( CELL(IDX1, IDX2, IDX3) = 1 )
                  SET LEADING-1(IDX2) TO IDX3
                  SET ROW-CHECKED TO TRUE
                ELSE
                  SET ROW-CHECKED TO TRUE
                  SET IS-NOT-RRE TO TRUE
                END-IF
           END-PERFORM.
           EXIT.

      * 2. If there are any rows that consist entirely of zeros, then
      * they are grouped together at the bottom of the matrix.
         RULE-2.
             SET ROW-NOT-CHECKED TO TRUE
           PERFORM VARYING IDX3 FROM 1 BY 1
              UNTIL IDX3 > DIM-X(IDX1) OR ROW-CHECKED OR IS-NOT-RRE
             IF (CELL(IDX1,IDX2,IDX3) IS NOT ZERO)
               IF (ZERO-ROW-FOUND)
                 SET IS-NOT-RRE TO TRUE
               ELSE
                 SET ROW-CHECKED TO TRUE
               END-IF
             END-IF
           END-PERFORM.
           IF (ROW-NOT-CHECKED)
             SET ZERO-ROW-FOUND TO TRUE
           END-IF.
           EXIT.

      * 3. In any two successive rows that do not consist entirely of
      * zeros, the leading 1 in the lower row occurs farther to the
      * right than the leading 1 in the higher row.
         RULE-3.
           PERFORM VARYING IDX3 FROM IDX2 BY 1
             UNTIL IDX3 > DIM-Y(IDX1) OR IS-NOT-RRE
             IF (LEADING-1(IDX3) < LEADING-1(IDX2)
                AND LEADING-1(IDX3) IS NOT ZERO)
               SET IS-NOT-RRE TO TRUE
             END-IF
           END-PERFORM.
           EXIT.

      * 4. Each column that contains a leading 1 has zeros everywhere
      * else in that column.
         RULE-4.
           PERFORM VARYING IDX2 FROM 1 BY 1 UNTIL IDX2 > DIM-Y(IDX1)
              OR IS-NOT-RRE
             IF (LEADING-1(IDX2) IS NOT ZERO)
               PERFORM VARYING IDX3 FROM 1 BY 1 UNTIL IDX3 > DIM-Y(IDX1)
                  OR IS-NOT-RRE
                 IF (IDX2 IS NOT = IDX3
                    AND CELL(IDX1, IDX3, LEADING-1(IDX2)) IS NOT ZERO)
                   SET IS-NOT-RRE TO TRUE
                 END-IF
               END-PERFORM
             END-IF
           END-PERFORM.
           EXIT.
