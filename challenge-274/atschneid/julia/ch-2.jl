
struct Schedule
    step::Int
    start::Int
    duration::Int
end

function find_next_bus_info( t::Int, sched::Schedule )
    factor = 1 + div( ( t - sched.start - 1 ), sched.step, RoundDown )    
    depart = factor * sched.step + sched.start
    depart, depart + sched.duration
end
    

function find_switch_times( schedules )
    num_minutes = 60
    output = Vector{Int}()

    for t = 0:num_minutes - 1
        depart_arrive_vals = Vector{Tuple{Int, Int}}()

        for sched = schedules
            push!( depart_arrive_vals, find_next_bus_info( t, sched ) )
        end
        
        if sort( depart_arrive_vals )[1][2] != sort( map( (x) -> x[2], depart_arrive_vals ) )[1]
            push!( output, t )
        end
    end
    output
end

inputs = [
    [
        Schedule( 12, 11, 41),
        Schedule( 15, 5, 35)
    ],
    [
        Schedule( 12, 3, 41),
        Schedule( 15, 9, 35),
        Schedule( 30, 5, 25)
    ],
]
for schedules in inputs
    println( find_switch_times( schedules ) )
end
             
                                                    
            
