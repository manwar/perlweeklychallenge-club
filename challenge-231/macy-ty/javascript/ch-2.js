function seniorCitizens (...elements){
    var senior = 0;
    for(value of elements){
        const age = value.slice(-4, -2);
        if (age >= 60){senior++}
    }
    console.log("Number of senior(s): " + senior);
}

seniorCitizens ("7868190130M7522","5303914400F9211","9273338290F4010")
