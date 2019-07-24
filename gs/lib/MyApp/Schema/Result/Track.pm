use utf8;
package MyApp::Schema::Result::Track;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Track

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

=head1 TABLE: C<track>

=cut

__PACKAGE__->table("track");

=head1 ACCESSORS

=head2 trackid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 cdid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 title

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "trackid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "cdid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "title",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</trackid>

=back

=cut

__PACKAGE__->set_primary_key("trackid");

=head1 UNIQUE CONSTRAINTS

=head2 C<title_cdid_unique>

=over 4

=item * L</title>

=item * L</cdid>

=back

=cut

__PACKAGE__->add_unique_constraint("title_cdid_unique", ["title", "cdid"]);

=head1 RELATIONS

=head2 cdid

Type: belongs_to

Related object: L<MyApp::Schema::Result::Cd>

=cut

__PACKAGE__->belongs_to(
  "cdid",
  "MyApp::Schema::Result::Cd",
  { cdid => "cdid" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 track_events

Type: has_many

Related object: L<MyApp::Schema::Result::TrackEvent>

=cut

__PACKAGE__->has_many(
  "track_events",
  "MyApp::Schema::Result::TrackEvent",
  { "foreign.trackid" => "self.trackid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-21 16:25:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ndic7hrAdbJ6nVmRd7Z1/w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
