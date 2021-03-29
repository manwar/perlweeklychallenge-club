!
! See ../README.md
!

!
! Run as: gfortran -o ch-1.o ch-1.f90; ./ch-1.o
!
! Input will consist of lines; each line will have two numbers, N and k, N > 0,
! k > 0. For each line of input, we output a line with the Nth root of k.
!
! We're not doing any input validations; we're assuming it's correct.
!

!
! To find the Nth root of a number k, we just raise k to the power 1/N
!

program nth_root
    implicit none
    integer :: N, k, ios

    do
        read (*, *, IOSTAT = ios) N, k
        if (ios /= 0) exit
        write (*, *) k ** (1.0 / N)
    end do
end
