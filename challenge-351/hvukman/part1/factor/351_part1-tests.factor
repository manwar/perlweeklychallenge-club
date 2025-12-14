! Copyright (C) 2025 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: tools.test 351part1 ;
IN: 351part1.tests

{ 5250 } [ { 8000 5000 6000 2000 3000 7000 } specialavg ] unit-test
{ 95000 } [ { 100000 80000 110000 90000 } specialavg ] unit-test
{ 0 } [ { 2500 2500 2500 2500 } specialavg ] unit-test
{ 0 } [ { 2000 } specialavg ] unit-test
{ 3500 } [ { 1000 2000 3000 4000 5000 6000 } specialavg ] unit-test
