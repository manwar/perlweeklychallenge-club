#!/usr/bin/env kotlin

/*
 * You are given a list of passenger details in the form “9999999999A1122”,
 * where 9 denotes the phone number, A the gender, 1 the age and 2 the seat
 * number.  Write a script to return the count of all senior citizens (age >=
 * 60).
 */

data class Passenger(
    val phone: String,
    val gender: String,
    val age: Int,
    val seat: String,
) {
    companion object {
        private val DETAILS_REGEX = Regex(
            """
            (?<phone>\d+)
            (?<gender>\p{Alpha})
            (?<age>\d{2})
            (?<seat>\d{2})
            """,
            RegexOption.COMMENTS,
        )
        operator fun invoke(details: String): Passenger {
            val match = DETAILS_REGEX.matchEntire(details)
                ?: throw IllegalArgumentException("Invalid details $details")
            val (phone, gender, age, seat) = match.destructured
            return Passenger(phone, gender, age.toInt(), seat)
        }
    }
}

fun passengers(vararg details: String) =
    details.map { Passenger(it) }

fun seniorCitizens(passengers: List<Passenger>) =
    passengers.filter { it.age >= 60 }

println(
    seniorCitizens(
        passengers("7868190130M7522", "5303914400F9211", "9273338290F4010"),
    ).size,
)
println(
    seniorCitizens(
        passengers("1313579440F2036", "2921522980M5644"),
    ).size,
)
