# run from project home directory
dbicdump -o dump_directory=./lib \
             -o components='["InflateColumn::DateTime"]' \
	     -o use_moose=1 \
             -o debug=1 \
             MyApp::Schema \
             'dbi:SQLite:./db/example.db'
