#!/usr/bin/env perl
use warnings; use strict; use feature 'say';

use lib 'lib';
use Carp;
use MyApp::Schema;

# Schema->connect( $dsn, $u, $p, $extra )
my $schema = MyApp::Schema->connect( "DBI:SQLite:dbname=db/example.db",
    '', 
    '', 
    { sqlite_unicode => 1, Taint => 1,},
    )
        or croak 'failed to connect to SQLite3 database. ', 
                 MyApp::Schema::errstr();

#  { sqlite_unicode => 1, Taint => 1, AutoCommit => 1, PrintWarn => 1, 
#    PrintError => 1, RaiseError => 1, ShowErrorStatement => 1, },
#    )

my $ee = $schema->resultset('Employee')->create( { 
    ee_number  => 101,
    first_name => 'Herman',
    last_name  => 'Munster',
    address    => '1313 Mocking Bird Lane',
    } );
say $ee->events->count;    # is now 1, an 'insert' event
$ee->change_last_name('Smith');    # add a name_change event
$ee->update;    # An update event, last_info_change_id and name

# Find their previous name
my $name_change = $ee->last_info_change;
print $name_change->details->{old}, "\n";

$ee->change_first_name('Don');    # add a name_change event
$ee->update;    # An update event, last_info_change_id and name

# Find their previous name
$name_change = $ee->last_info_change;
print $name_change->details->{old}, "\n";

$ee->change_address('1410 Cambridge Ave');    # add a name_change event
$ee->update;    # An update event, last_info_change_id and name

# Find their previous name
my $addr_change = $ee->last_info_change;
print $addr_change->details->{old}, "\n";
exit 0;
1;

