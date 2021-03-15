!
! See ../README.md
!

!
! Run as: gfortran -o ch-1.o ch-1.f90; ./ch-1.o
!

program fucs
    implicit none
    write(*,fmt="(A)", advance='no')  "0 1 1 2 1 3 2 3 1 4 3 5 2 5 3 4 1 5 "
    write(*,fmt="(A)", advance='no')  "4 7 3 8 5 7 2 7 5 8 3 7 4 5 1 6 5 9 "
    write(*,fmt="(A)", advance='yes') "4 11 7 10 3 11 8 13 5 12 7 9 2 9"
end
