program reversible_numbers  
implicit none

integer :: i
do i = 1, 100
    if(is_reversible(i)) then
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
        i = size(digits)
        m = n
        do while(m /= 0)
            d = mod(m, 10)
            digits(i) = d
            m = m / 10;
            i = i - 1
        end do
    end function int2digits

    function digits2int(digits) result(r)
        integer, intent(in) :: digits(:)
        integer :: i, x, r, n
        x = 1
        r = 0
        do i = 1, size(digits)
            r = (r + (digits(size(digits) - i + 1) * x))
            x = (x * 10)
        end do
    end function digits2int 
    
    function reverse_digits(digits) result(stigid)
        integer, intent(in) :: digits(:)
        integer, allocatable :: stigid(:)
        integer :: i
        allocate(stigid(size(digits)))
        do i = 1, size(digits)
            stigid(size(digits) - i + 1) = digits(i)
        end do
    end function reverse_digits

    function is_reversible(x) result(reversible)
        integer, intent(in) :: x
        integer :: x_r, sum, m, i
        logical :: reversible 
        integer :: number_digits_x, number_digits_sum
        integer, allocatable :: x_digits(:), x_digits_reversed(:), sum_digits(:)
        number_digits_x = floor(log10(real(x)) + 1)
        allocate(x_digits(number_digits_x))
        allocate(x_digits_reversed(number_digits_x))
        x_digits = int2digits(x)
        x_digits_reversed = reverse_digits(x_digits)
        x_r = digits2int(x_digits_reversed)
        sum = x + x_r        
        number_digits_sum = floor(log10(real(sum)) + 1)
        allocate(sum_digits(number_digits_sum))
        sum_digits = int2digits(sum)
        reversible = .true.
        do i = 1, size(sum_digits)
            m = mod(sum_digits(i), 2)
            if(m == 0) then
                reversible = .false.
            end if
        end do
    end function is_reversible

end program reversible_numbers 
