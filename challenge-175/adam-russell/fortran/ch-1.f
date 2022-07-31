program last_sunday
use datetime_module, only: datetime
implicit none

character(10), dimension(12) :: last_sundays  
integer :: month 
do month = 1, 12 
    last_sundays(month) = last_sunday_month(month, 2022) 
end do
do month = 1, 12 
    write(*, *) last_sundays(month)  
end do

contains

    function last_sunday_month(month, year) result(sunday)  
        integer, intent(in) :: month, year
        integer :: day
        character(10) :: sunday
        type(datetime) :: date
        do day = 20, 31
            date = datetime(year, month, day)
            if (date%isValid() .and. date%weekday() == 0) then
                write(sunday, '(i4,a1,i0.2,a1,i2)') year, '-', month, '-', day 
            end if     
        end do  
    end function last_sunday_month

end program last_sunday
