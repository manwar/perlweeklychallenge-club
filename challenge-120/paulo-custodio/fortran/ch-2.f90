! Challenge 120
!
! TASK #2 - Clock Angle
! Submitted by: Mohammad S Anwar
! You are given time $T in the format hh:mm.
!
! Write a script to find the smaller angle formed by the hands of an analog
! clock at a given time.
!
! HINT: A analog clock is divided up into 12 sectors. One sector represents 30
! degree (360/12 = 30).
!
! Example
! Input: $T = '03:10'
! Output: 35 degree
!
! The distance between the 2 and the 3 on the clock is 30 degree.
! For the 10 minutes i.e. 1/6 of an hour that have passed.
! The hour hand has also moved 1/6 of the distance between the 3 and the 4,
! which adds 5 degree (1/6 of 30).
! The total measure of the angle is 35 degree.
!
! Input: $T = '04:00'
! Output: 120 degree

program ch2
    implicit none

    integer :: hh, mm, hh_angle, mm_angle, angle, stat, p
    character(len=50) :: arg

    call get_command_argument(1, arg)
    if (len_trim(arg) /= 0) then
        p = index(arg, ':')
        if (p /= 0) then
            read(arg(:p-1),*,iostat=stat) hh
            read(arg(p+1:),*,iostat=stat) mm

            mm_angle = mm*360/60
            hh_angle = mod(hh, 12)*360/12 + mm_angle/12

            angle = abs(hh_angle - mm_angle)
            if (angle > 180) then
                angle = 360 - angle
            end if

            print *, angle
        end if
    end if
end program ch2
