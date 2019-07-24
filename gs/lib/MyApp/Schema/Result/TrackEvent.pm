use utf8;
package MyApp::Schema::Result::TrackEvent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::TrackEvent

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

=head1 TABLE: C<track_event>

=cut

__PACKAGE__->table("track_event");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 trackid

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

=head2 title

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "trackid",
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
  "title",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 trackid

Type: belongs_to

Related object: L<MyApp::Schema::Result::Track>

=cut

__PACKAGE__->belongs_to(
  "trackid",
  "MyApp::Schema::Result::Track",
  { trackid => "trackid" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-20 22:19:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KFPyYzSm3khqNlJmiwSrNw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
