! Challenge 120
!
! TASK #1 - Swap Odd/Even bits
! Submitted by: Mohammad S Anwar
! You are given a positive integer $N less than or equal to 255.
!
! Write a script to swap the odd positioned bit with even positioned bit and
! print the decimal equivalent of the new binary representation.
!
! Example
! Input: $N = 101
! Output: 154
!
! Binary representation of the given number is 01 10 01 01.
! The new binary representation after the odd/even swap is 10 01 10 10.
! The decimal equivalent of 10011010 is 154.
!
! Input: $N = 18
! Output: 33
!
! Binary representation of the given number is 00 01 00 10.
! The new binary representation after the odd/even swap is 00 10 00 01.
! The decimal equivalent of 100001 is 33.

program ch1
    implicit none

    integer :: n, stat
    character(len=50) :: arg

    call get_command_argument(1, arg)
    if (len_trim(arg) /= 0) then
        read(arg,*,iostat=stat) n
        n = swap_bits(n)
        print *, n
    end if

contains
    function swap_bits(n)
        integer :: swap_bits, n, output, shift

        output = 0
        shift = 1

        do while (n > 0)
            if (mod(n, 2) /= 0) then
                output = output + 2*shift
            end if
            n = n / 2
            if (mod(n, 2) /= 0) then
                output = output + 1*shift
            end if
            n = n / 2
            shift = shift*4
        end do
        swap_bits = output
    end function swap_bits
end program ch1
