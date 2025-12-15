! Copyright (C) 2025 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: tools.test 351part2 ;
IN: 351part2.tests

{ t } [ { 1 3 5 7 9 } arithprog? ] unit-test
{ t } [ { 9 1 7 5 3 } arithprog? ] unit-test
{ f } [ { 1 2 4 8 16 } arithprog? ] unit-test
{ t } [ { 5 -1 3 1 -3 } arithprog? ] unit-test
{ t } [ { 5 -1 3 1 -3 } arithprog? ] unit-test
{ t } [ { 1.5 3 0 4.5 6 } arithprog? ] unit-test
