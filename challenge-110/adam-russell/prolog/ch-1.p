/*
 Write a script to display all valid phone numbers in a given text file.     
*/
%:-initialization(main).

phone_number --> prefx,  space, area_exchange_subscriber.
prefx  --> ['('], digit, digit, [')'].
prefx --> ['+'], digit, digit.
prefx --> digit, digit, digit, digit.
space --> [' '].
area_exchange_subscriber --> digit, digit, digit, digit, digit, digit, digit, digit, digit, digit.
digit --> [0]; [1]; [2]; [3]; [4]; [5]; [6]; [7]; [8]; [9].



main:-
    halt.