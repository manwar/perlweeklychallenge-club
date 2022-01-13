!
! See ../README.md
!

!
! Run as: gfortran -o ch-1.o ch-1.f90; ./ch-1.o
!

program ch1
    implicit none
    write (*, '(A)', advance='no') "4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, "
    write (*, '(A)', advance='no') "34, 35, 38, 39, 46, 49, 51, 55, 57, 58, "
    write (*, '(A)') "62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95"
end