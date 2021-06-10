PROGRAM address
!===============================================================================
!
!         FILE: 10801.f95
!
!        USAGE: f95 10801.f95 && ./a.out
!
!  DESCRIPTION: Store a scalar and print the memory address of it
!
!       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
! ORGANIZATION: Openstrike
!      VERSION: 1.0
!      CREATED: 16/04/21
!===============================================================================
IMPLICIT NONE
INTEGER :: I = 5
PRINT ('("I is at address 0x", Z8.8)'), LOC(I)
END PROGRAM address
