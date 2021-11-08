! Challenge 119
!
! TASK #2 - Sequence without 1-on-1
! Submitted by: Cheok-Yin Fung
! Write a script to generate sequence starting at 1. Consider the increasing
! sequence of integers which contain only 1's, 2's and 3's, and do not have any
! doublets of 1's like below. Please accept a positive integer $N and print the
! $Nth term in the generated sequence.
!
! 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
!
! Example
! Input: $N = 5
! Output: 13
!
! Input: $N = 10
! Output: 32
!
! Input: $N = 60
! Output: 2223

program ch2
    implicit none

    integer :: i, num, n, stat
    character(len=50) :: arg

    call get_command_argument(1, arg)
    if (len_trim(arg) /= 0) then
        read(arg,*,iostat=stat) num

        n = 0
        do i = 1, num
            n = next_seq(n)
        end do

        print *, n
    end if

contains
    function num_ok(n1)
        logical :: num_ok
        integer, intent(in) :: n1
        integer :: n, digit, last_digit
        logical :: failed

        n = n1
        failed = .false.
        if (n <= 0) then
            failed = .true.
        end if

        digit = 0
        do while (n > 0)
            last_digit = digit
            digit = mod(n, 10)
            n = n / 10
            if (digit < 1 .or. digit > 3 .or. (digit == 1 .and. last_digit == 1)) then
                failed = .true.
            end if
        end do

        num_ok = .not. failed
    end function num_ok

    function next_seq(n1)
        integer :: next_seq
        integer, intent(in) :: n1
        integer :: n

        n = n1
        n = n+1
        do while (.true.)
            if (num_ok(n)) then
                exit
            else
                n = n+1
            end if
        end do

        next_seq = n
    end function next_seq
end program ch2
