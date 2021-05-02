/*
 Write a script to display all valid phone numbers in a given text file.     
*/
:-initialization(main).

test('0044 1148820341').  
test('+44 1148820341').  
test('44-11-4882-0341').  
test('(44) 1148820341').   
test('00 1148820341').  

phone_number --> prefx,  space, area_exchange_subscriber.
prefx  --> ['('], digit, digit, [')'].
prefx --> ['+'], digit, digit.
prefx --> digit, digit, digit, digit.
space --> [' '].
area_exchange_subscriber --> digit, digit, digit, digit, digit, digit, digit, digit, digit, digit.
digit --> ['0']; ['1']; ['2']; ['3']; ['4']; ['5']; ['6']; ['7']; ['8']; ['9'].

run_tests:-
    test(T),
    atom_chars(T, C),   
    phrase(phone_number, C),
    write(T), nl.

main:-
    run_tests.
