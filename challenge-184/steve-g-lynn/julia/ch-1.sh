#!/bin/sh

julia -e 'using Printf; ctr=0; for mystring in ARGS; global ctr; @printf "%02i" ctr; print(SubString(mystring,3,6));print(" ");ctr+=1;end;println("")' 'ab1234' 'cd5678' 'ef1342'

#001234 015678 021342

#julia -e 'using Printf; ctr=0; for mystring in ARGS; global ctr; @printf "%02i" ctr; print(SubString(mystring,3,6));print(" ");ctr+=1;end;println("")' 'pq1122' 'rs3334'

#001122 013334
