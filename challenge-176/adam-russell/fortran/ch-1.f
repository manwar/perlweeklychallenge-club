program permuted_multiple
implicit none



contains

    function int2digits(n) result(digits)
        integer, intent(in) :: n
        integer, allocatable :: digits(:)
        integer :: i, d, m, number_digits
        number_digits = floor(log10(real(n)) + 1)
        ALLOCATE(digits(number_digits))      
        i = 0
        m = n
        do while(m /= 0) 
            d = mod(m, 10)
            digits(i) = d
            m = m / 10; 
            i = i + 1 
        end do 
    
    end function int2digits

end program permuted_multiple