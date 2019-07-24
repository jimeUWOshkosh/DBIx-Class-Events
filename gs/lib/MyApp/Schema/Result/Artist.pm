use utf8;
package MyApp::Schema::Result::Artist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Artist

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

=head1 TABLE: C<artist>

=cut

__PACKAGE__->table("artist");

=head1 ACCESSORS

=head2 artistid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 last_name_change_id

  data_type: 'integer'
  default_value: -1
  is_foreign_key: 1
  is_nullable: 0

=head2 previousid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "artistid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "last_name_change_id",
  {
    data_type      => "integer",
    default_value  => -1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "previousid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</artistid>

=back

=cut

__PACKAGE__->set_primary_key("artistid");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_unique>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name_unique", ["name"]);

=head1 RELATIONS

=head2 artist_events

Type: has_many

Related object: L<MyApp::Schema::Result::ArtistEvent>

=cut

__PACKAGE__->has_many(
  "artist_events",
  "MyApp::Schema::Result::ArtistEvent",
  { "foreign.artistid" => "self.artistid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 artists

Type: has_many

Related object: L<MyApp::Schema::Result::Artist>

=cut

__PACKAGE__->has_many(
  "artists",
  "MyApp::Schema::Result::Artist",
  { "foreign.previousid" => "self.artistid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cds

Type: has_many

Related object: L<MyApp::Schema::Result::Cd>

=cut

__PACKAGE__->has_many(
  "cds",
  "MyApp::Schema::Result::Cd",
  { "foreign.artistid" => "self.artistid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 last_name_change

Type: belongs_to

Related object: L<MyApp::Schema::Result::ArtistEvent>

=cut

__PACKAGE__->belongs_to(
  "last_name_change",
  "MyApp::Schema::Result::ArtistEvent",
  { artisteventid => "last_name_change_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 previousid

Type: belongs_to

Related object: L<MyApp::Schema::Result::Artist>

=cut

__PACKAGE__->belongs_to(
  "previousid",
  "MyApp::Schema::Result::Artist",
  { artistid => "previousid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-21 17:53:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PIwtRWdHSeMYKlC+NfH/Bg
    __PACKAGE__->load_components( qw/ Events / );

    # A different name can be used with the "events_relationship" attribute
    __PACKAGE__->has_many(
        'events' => ( 'MyApp::Schema::Result::ArtistEvent', 'artistid' ),
        { cascade_delete => 0 },
    );

   __PACKAGE__->has_one(
        'last_name_change'        => 'MyApp::Schema::Result::ArtistEvent',
        { 'foreign.artisteventid' => 'self.last_name_change_id' },
        { cascade_delete          => 0 },
    );

    sub change_name {
        my ( $self, $new_name ) = @_;

        my $event = $self->event( name_change =>
                { details => { new => $new_name, old => $self->name } } );
        $self->last_name_change( $event );
        # $self->update; # be lazy and make our caller call ->update

        $self->name( $new_name );
    }


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
