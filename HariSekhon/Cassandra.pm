#
#  Author: Hari Sekhon
#  Date: 2013-11-03 03:58:28 +0000 (Sun, 03 Nov 2013)
#
#  http://github.com/harisekhon
#
#  License: see accompanying LICENSE file
#  

package HariSekhon::Cassandra;

$VERSION = "0.1";

use strict;
use warnings;
BEGIN {
    use File::Basename;
    use lib dirname(__FILE__) . "..";
}
use HariSekhonUtils;
use Carp;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT = ( qw (
                    %DEFAULT_CASSANDRA_PORT
                    $cassandra_cql_port
                    $cassandra_jmx_port
                    $cassandra_thrift_port
                )
);
our @EXPORT_OK = ( @EXPORT );

our %DEFAULT_CASSANDRA_PORT = (
    "CQL"    => 9042,
    "JMX"    => 7199,
    "THRIFT" => 9160,
);

if($ENV{"CASSANDRA_USER"}){
    $main::user = $ENV{"CASSANDRA_USER"};
}
if($ENV{"CASSANDRA_PASSWORD"}){
    $main::password = $ENV{"CASSANDRA_PASSWORD"};
}

our %cassandra_options = (
    "H|host=s"         => [ \$main::host,         "Cassandra node to connect to" ],
);

sub set_cassandra_port($){
    my $type         = shift;
    defined($type) or code_error "no type passed to set_cassandra_port";
    defined($DEFAULT_CASSANDRA_PORT{$type}) or code_error "'$type' cassandra port not defined in HariSekhon::Cassandra::DEFAULT_CASSANDRA_PORT hash, passed in wrong type as arg?";
    %cassandra_options = (
        %cassandra_options,
        "P|port=s"         => [ \$main::port,         sprintf("Cassandra %s port to connect to (default: %d)", $type, $DEFAULT_CASSANDRA_PORT{$type}) ],
        "u|user=s"         => [ \$main::user,         sprintf("Cassandra %s User (optional)", $type) ],
        "p|password=s"     => [ \$main::password,     sprintf("Cassandra %s Password (optional)", $type) ],
    );
    return $DEFAULT_CASSANDRA_PORT{$type};
}
