#!/usr/bin/env perl
use warnings; use strict; use feature 'say';
use lib 'lib';
use MyApp::Schema;

my $db_fn = 'db/example.db';
my $schema = MyApp::Schema->connect("dbi:SQLite:$db_fn");

my $artist = $schema->resultset('Artist')->create( { name => 'Michael Jackson' } );
my $cd = $schema->resultset('Cd')->create( 
	{ artistid => $artist->artistid,
	  title    => 'Thriller',
	  year     =>  1984,
	} );
$cd->year(1985);
$cd->update;

