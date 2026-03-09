use 5.040;

use Net::IPv4Addr 'ipv4_in_network', 'ipv4_chkip';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/#TASK2

sub subnet_sheriff($ipv4_address, $ipv4_cidr) {
    eval { ipv4_chkip($ipv4_cidr) && ipv4_chkip($ipv4_address) && ipv4_in_network($ipv4_cidr, $ipv4_address) } // false
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        sub($inputs) { subnet_sheriff($inputs->{"ip_addr"}, $inputs->{"domain"}) },
        '{"ip_addr": "192.168.1.45", "domain": "192.168.1.0/24"}',
        '{
            "type": "object",
            "properties": {
                "ip_addr": {"type": "string"},
                "domain": {"type": "string"}
            },
            "required": ["ip_addr", "domain"],
            "additionalProperties": false
        }',
    );
}
