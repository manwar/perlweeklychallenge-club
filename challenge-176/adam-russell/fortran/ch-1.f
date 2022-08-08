program permuted_multiple
implicit none

integer :: i
logical :: l
do i = 1, 1000000
    if(is_permuted(i, i*2) .and. is_permuted(i*2, i*3) .and. &
       is_permuted(i*3, i*4) .and.  is_permuted(i*4, i*5) .and. &
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
        i = 1
        m = n
        do while(m /= 0) 
            d = mod(m, 10)
            digits(i) = d
            m = m / 10; 
            i = i + 1 
        end do 
    end function int2digits

    function is_permuted(x, y) result(permuted)
        integer, intent(in) :: x, y 
        integer :: i
        logical :: permuted 
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
        call insertion_sort(size(x_digits), x_digits)   
        call insertion_sort(size(y_digits), y_digits)
        permuted = .true.
        if(size(x_digits) /= size(y_digits)) then
            permuted = .false.
        else
            do i = 1, size(x_digits)
                if(x_digits(i) /= y_digits(i)) then
                    permuted = .false.
                end if
            end do
        end if
    end function is_permuted  
    
    ! sort code from https://github.com/yet-another-alex/basic-fortran-examples/blob/master/sorting.f90
	subroutine insertion_sort(msize, array)
		implicit none
		! variables
		integer, intent(in) :: msize
		integer, intent(inout) :: array(msize)
		integer :: prev_index, i, insert

		do i = 1, msize
			! current item to insert
			insert = array(i)
			! previous index
			prev_index = i - 1
			! if the item is larger, move everything forward
			do while ((prev_index > 0) .and. (array(prev_index) > insert))
				array(prev_index + 1) = array(prev_index)
				prev_index = prev_index - 1
			end do
			! insert the item
			array(prev_index + 1) = insert
		end do
	end subroutine insertion_sort

end program permuted_multiple
