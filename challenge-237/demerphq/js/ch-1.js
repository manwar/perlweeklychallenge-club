"use strict";

function mdayForWeekDow(yearNum, month, week, dow) {
    const initialTime = new Date(Date.UTC(yearNum, month, 1, 12, 0, 0, 0));
    let time = Math.floor( initialTime.getTime() / 1000 );
    let date;

    while (true) {
        date = new Date(time * 1000);
        if (date.getUTCDay() === dow) {
            break;
        }
        time += 24 * 60 * 60;
    }

    for (; week > 1; week--) {
        time += 7 * 24 * 60 * 60;
        date = new Date(time * 1000);
        if (date.getUTCMonth() !== month) {
            return 0;
        }
    }

    return date.getUTCDate();
}

const dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const monthNames = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];

function numSuffix(n) {
    return n + (n === 1 ? "st" : n === 2 ? "nd" : n === 3 ? "rd" : "th");
}

const testCases = [
    [2024, 4, 1, 2],
    [2025, 10, 2, 4],
    [2026, 8, 5, 3],
];

testCases.forEach(([year, month, week, dow]) => {
    const mday = mdayForWeekDow(year, month - 1, week, dow);
    const dayName = dayNames[dow];
    const monthName = monthNames[month - 1];
    if (mday) {
        console.log(`The ${numSuffix(week)} ${dayName} of ${year} ${monthName} is the ${numSuffix(mday)}`);
    } else {
        console.log(`The ${numSuffix(week)} ${dayName} of ${year} ${monthName} does not exist`);
    }
});

