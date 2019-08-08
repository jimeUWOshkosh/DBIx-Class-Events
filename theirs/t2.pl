#!/usr/bin/env perl
use warnings; use strict; use feature 'say';
use lib 'lib';
use MyApp::Schema;

my $db_fn = 'db/example.db';
my $schema = MyApp::Schema->connect("dbi:SQLite:$db_fn");

my $artist = $schema->resultset('Artist')->create( { name => 'Devo' } );
my $cd = $schema->resultset('Cd')->create( 
	{ artistid => $artist->artistid,
	  title    => 'FreedomofChoice',
	  year     =>  1980,
	} );
$cd->year(1984);
$cd->title('Freedom of Choice');
$cd->update;

