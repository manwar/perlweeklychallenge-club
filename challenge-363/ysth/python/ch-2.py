
import ipaddress 

# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/#TASK2

def subnet_sheriff(ip_addr: str, domain: str) -> bool:
    result: bool = False
    try:
        result = ipaddress.ip_address(ip_addr) in ipaddress.ip_network(domain)
    except:
        pass
    return result

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge_v2(
        run_solution = lambda inputs: subnet_sheriff(run.as_str(inputs,"ip_addr"),run.as_str(inputs,"domain")),
        inputs_example = '{"ip_addr": "192.168.1.45", "domain": "192.168.1.0/24"}',
        inputs_schema_json = '''{
            "type": "object",
            "properties": {
                "ip_addr": {"type": "string"},
                "domain": {"type": "string"}
            },
            "required": ["ip_addr", "domain"],
            "additionalProperties": false
        }''',
    )
