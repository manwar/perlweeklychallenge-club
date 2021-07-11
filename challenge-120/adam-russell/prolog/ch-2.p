:-initialization(main).

clock_angle(Time, Angle):-
    append(H, [58|M], Time),  
    number_codes(Hour, H),
    number_codes(Minutes, M),
    A is abs(0.5 * (60 * Hour - 11 * Minutes)), 
    ((A > 180, Angle is 360 - A); Angle = A). 

main:-
    clock_angle("03:10", Angle),
    write(Angle), nl,  
    halt. 
