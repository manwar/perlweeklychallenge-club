! Challenge 118
!
! TASK #1 - Binary Palindrome
! Submitted by : Mohammad S Anwar
! You are given a positive integer $N.
!
! Write a script to find out if the binary representation of the given integer
! is Palindrome. Print 1 if it is otherwise 0.
! Example
!
! Input: $N = 5
! Output : 1 as binary representation of 5 is 101 which is Palindrome.
!
! Input : $N = 4
! Output : 0 as binary representation of 4 is 100 which is NOT Palindrome.

program ch1
    implicit none

    character(len=50) :: arg, bin
    integer :: n, stat

    call get_command_argument(1, arg)
    if (len_trim(arg) /= 0) then
        read(arg,*,iostat=stat) n
        if (is_palindrome(n)) then
            print *, 1
        else
            print *, 0
        end if
    end if

contains
    subroutine dec2bin(n1, bin)
        integer, intent(in) :: n1
        character(len=50), intent(out) :: bin
        integer :: n

        n = n1
        bin = ''
        do while (n > 0)
            if (and(n, 1) /= 0) then
                bin = trim(bin) // '1'
            else
                bin = trim(bin) // '0'
            end if
            n = n/2
        end do
    end subroutine dec2bin

    function is_palindrome(n)
        logical :: is_palindrome
        integer, intent(in) :: n
        character(len=50) :: bin
        logical :: ok
        integer :: length, i, j

        call dec2bin(n, bin)
        ok = .true.
        length = len_trim(bin)
        do i = 1, length
            j = length-i+1
            if (bin(i:i) /= bin(j:j)) then
                ok = .false.
            end if
        end do
        is_palindrome = ok
    end function is_palindrome
end program ch1
