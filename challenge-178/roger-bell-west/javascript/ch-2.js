#! /usr/bin/node

"use strict"

function addbizhours(start, delta) {
    let current = new Date(Date.parse(start));
    let seconds = 3600 * delta;
    let bizdaylength = 3600 * 9;
    if (!isbiz(current)) {
        current = nextbizstart(current);
    }
    let ed = nextbizend(current);
    let remain = Math.floor((ed - current) / 1000);
    if (remain < seconds) {
        seconds -= remain;
        current = nextbizstart(ed);
        while (seconds > bizdaylength) {
            current = nextbizstart(current);
            seconds -= bizdaylength;
        }
    }
    current.setSeconds(current.getSeconds() + seconds);
    return current.getFullYear().toString().padStart(4, "0") + "-" +
        (current.getMonth()+1).toString().padStart(2, "0") + "-" +
        current.getDate().toString().padStart(2, "0") + " " +
        current.getHours().toString().padStart(2, "0") + ":" +
        current.getMinutes().toString().padStart(2, "0");
}

function isbiz(tm) {
    if (tm.getDay() == 0 || tm.getDay() == 6) {
        return false;
    }
    if (tm.getHours() < 9 || tm.getHours() >= 18) {
        return false;
    }
    return true;
}

function nextbizstart(tm0) {
    let tm = new Date(tm0);
    while (tm.getDay() == 0 || tm.getDay() == 6) {
        tm.setDate(tm.getDate() + 1);
        tm.setHours(9);
        tm.setMinutes(0);
        tm.setSeconds(0);
    }
    if (tm.getHours() < 9) {
        tm.setHours(9);
        tm.setMinutes(0);
        tm.setSeconds(0);
    } else {
        while (true) {
            tm.setDate(tm.getDate() + 1);
            tm.setHours(9);
            tm.setMinutes(0);
            tm.setSeconds(0);
            if (tm.getDay() >= 1 && tm.getDay() <= 5) {
                break;
            }
        }
    }
    return tm;
}

function nextbizend(tm0) {
    let tm = new Date(tm0);
    while (tm.getDay() == 0 || tm.getDay() == 6) {
        tm.setDate(tm.getDate() + 1);
        tm.setHours(18);
        tm.setMinutes(0);
        tm.setSeconds(0);
    }
    if (tm.getHours() >= 18) {
        while (true) {
            tm.setDate(tm.getDate() + 1);
            tm.setHours(18);
            tm.setMinutes(0);
            tm.setSeconds(0);
            if (tm.getDay() >= 1 && tm.getDay() <= 5) {
                break;
            }
        }
    } else {
        tm.setHours(18);
        tm.setMinutes(0);
        tm.setSeconds(0);
    }
    return tm;
}

if (addbizhours("2022-08-01 10:30", 4) == "2022-08-01 14:30") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (addbizhours("2022-08-01 17:00", 3.5) == "2022-08-02 11:30") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (addbizhours("2022-08-01 18:00", 3.5) == "2022-08-02 12:30") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (addbizhours("2022-08-01 19:00", 3.5) == "2022-08-02 12:30") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (addbizhours("2022-08-05 17:00", 3.5) == "2022-08-08 11:30") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (addbizhours("2022-08-01 12:00", 18) == "2022-08-03 12:00") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
