program permuted_multiple
use stdlib_sorting, only: sort
implicit none

do i = 1, 1000000
    if(is_permuted(i, i*2) .and. is_permuted(i*2, i*3) .and.
    is_permuted(i*3, i*4) .and.  is_permuted(i*4, i*5) .and.
    is_permuted(i*5, i*6)) then
          print *, i
    end if 
end do


contains

    function int2digits(n) result(digits)
        integer, intent(in) :: n
        integer, allocatable :: digits(:)
        integer :: i, d, m, number_digits
        number_digits = floor(log10(real(n)) + 1)
        allocate(digits(number_digits))      
        i = 0
        m = n
        do while(m /= 0) 
            d = mod(m, 10)
            digits(i) = d
            m = m / 10; 
            i = i + 1 
        end do 
    end function int2digits

    function is_permuted(x, y) result(is_permuted)
        integer, intent(in) :: x, y 
        logical :: is_permuted 
        integer :: number_digits_x
        integer :: number_digits_y  
        integer, allocatable :: x_digits(:)
        integer, allocatable :: y_digits(:)
        number_digits_x = floor(log10(real(x)) + 1)
        number_digits_y = floor(log10(real(y)) + 1)
        allocate(x_digits(number_digits_x))      
        allocate(y_digits(number_digits_y))      
        x_digits = int2digits(x)
        y_digits = int2digits(y)
        call sort(x_digits)   
        call sort(y_digits)   
        is_permuted = x_digits == y_digits 
    end function is_permuted  

end program permuted_multiple
