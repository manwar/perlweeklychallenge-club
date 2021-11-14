define(`com')dnl
com()dnl
com(`Macros to simulate an array. First macros fetches a value')dnl
com(`while the second macro sets a value.')dnl
com()dnl
define(`tail',`defn(format(``tail[%d]'',`$1'))')dnl
define(`tail_set',`define(format(``tail[%d]'',`$1'),`1023456$2')')dnl
com()dnl
com(`Load the "tail" array with values')dnl
com()dnl
tail_set(`5',`789')dnl
tail_set(`4',`798')dnl
tail_set(`3',`879')dnl
tail_set(`2',`897')dnl
tail_set(`1',`978')dnl
com()dnl
com(`Recursive macro to print the results from the given value')dnl
com(`down to "1". Better call it with a positive integer value')dnl
com()dnl
define(`run',`tail($1)
ifelse($1,1,,`run(eval($1-1))')')dnl
com()dnl
com(`We want five values')dnl
com()dnl
run(5)dnl
