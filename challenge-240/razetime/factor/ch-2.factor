USING: kernel sequences ;
IN: pwc-240-1
: ch-1 ( seq -- seq' ) dup nths ;
{ 0 2 1 5 3 4 } ch-1 { 0 1 2 4 5 3 } assert=
{ 5 0 1 2 3 4 } ch-1 { 4 5 0 1 2 3 } assert=
