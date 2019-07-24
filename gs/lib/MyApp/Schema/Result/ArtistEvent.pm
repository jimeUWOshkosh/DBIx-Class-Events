use utf8;
package MyApp::Schema::Result::ArtistEvent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::ArtistEvent

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<artist_event>

=cut

__PACKAGE__->table("artist_event");

=head1 ACCESSORS

=head2 artisteventid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 artistid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 event

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 triggered_on

  data_type: 'datetime'
  default_value: current_timestamp
  is_nullable: 0

=head2 details

  data_type: 'longtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "artisteventid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "artistid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "event",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "triggered_on",
  {
    data_type     => "datetime",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "details",
  { data_type => "longtext", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</artisteventid>

=back

=cut

__PACKAGE__->set_primary_key("artisteventid");

=head1 RELATIONS

=head2 artistid

Type: belongs_to

Related object: L<MyApp::Schema::Result::Artist>

=cut

__PACKAGE__->belongs_to(
  "artistid",
  "MyApp::Schema::Result::Artist",
  { artistid => "artistid" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 artists

Type: has_many

Related object: L<MyApp::Schema::Result::Artist>

=cut

__PACKAGE__->has_many(
  "artists",
  "MyApp::Schema::Result::Artist",
  { "foreign.last_name_change_id" => "self.artisteventid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-20 22:19:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4b+IwCLp7AeNCsIDuFUdeg
use JSON::PP ();
    # You should set up automatic inflation/deflation of the details column
    # as it is used this way by "state_at" and the insert/update/delete
    # events.  Does not have to be JSON, just be able to serialize a hashref.
    {
	my $json = JSON::PP->new->utf8;
        __PACKAGE__->inflate_column( 'details' => {
            inflate => sub { $json->decode(shift) },
            deflate => sub { $json->encode(shift) },
        } );
    }

    # A path back to the object that this event is for,
    # not required unlike the has_many "events" relationship above
    __PACKAGE__->belongs_to(
        'artist' => ( 'MyApp::Schema::Result::Artist', 'artistid' ) );


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
