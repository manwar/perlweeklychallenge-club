"use strict";


function seniorCitizens(elements) {
    let count = 0;
    for (let elem of elements) {
        let groups = elem.match(/(?<age>\d{2})(?<seatNumber>\d{2})$/).groups;
        if (parseInt(groups.age) >= 60) {
            count++;
        }
    }
    return count;
}
