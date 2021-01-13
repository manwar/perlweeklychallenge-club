! To compile and run:
!
! $ gfortran ch-1.f95
! $ ./a.out 100
!       13015

function mygcd(a, b) result(x)
    integer, intent(in) :: a, b
    integer :: x, y, t

    x = a
    y = b

    do while (y /= 0)
        t = y
        y = mod(x, y)
        x = t
    end do
end function

program challenge89part1
    integer :: n, x, y, s

    character(len=20) :: arg
    character(len=20) :: nstr

    if (iargc() == 1) then
        call getarg(1, nstr)
        read(nstr,*) n
    else
        n = 3
    end if
    
    s = 0
    do x = 1, n
        do y = x + 1, n
            s = s + mygcd(x, y)
        end do
    end do

    write(*,*) s
end program
