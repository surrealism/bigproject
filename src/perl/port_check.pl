#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;

sub check_port {
    my ($host, $port) = @_;
    my $socket = IO::Socket::INET->new(
        PeerAddr => $host,
        PeerPort => $port,
        Proto    => 'tcp',
        Timeout  => 3,
    );
    if ($socket) {
        close($socket);
        return 1;
    }
    return 0;
}

my $host = $ARGV[0] || 'localhost';
my @ports = (22, 80, 443, 3306, 5432, 6379, 8080);

print "=== Port Scanner ===\n";
print "Host: $host\n\n";

for my $port (@ports) {
    my $status = check_port($host, $port) ? "OPEN" : "CLOSED";
    printf "Port %5d  %s\n", $port, $status;
}

print "\n--- Custom range 8000-8010 ---\n";
for my $port (8000..8010) {
    if (check_port($host, $port)) {
        printf "Port %5d  OPEN\n", $port;
    }
}

print "\nDone.\n";
