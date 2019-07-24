use utf8;
package MyApp::Schema::Result::Cd;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Cd

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

=head1 TABLE: C<cd>

=cut

__PACKAGE__->table("cd");

=head1 ACCESSORS

=head2 cdid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 artistid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 year

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "cdid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "artistid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
  "year",
  { data_type => "datetime", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cdid>

=back

=cut

__PACKAGE__->set_primary_key("cdid");

=head1 UNIQUE CONSTRAINTS

=head2 C<title_artistid_unique>

=over 4

=item * L</title>

=item * L</artistid>

=back

=cut

__PACKAGE__->add_unique_constraint("title_artistid_unique", ["title", "artistid"]);

=head1 RELATIONS

=head2 artistid

Type: belongs_to

Related object: L<MyApp::Schema::Result::Artist>

=cut

__PACKAGE__->belongs_to(
  "artistid",
  "MyApp::Schema::Result::Artist",
  { artistid => "artistid" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 cd_events

Type: has_many

Related object: L<MyApp::Schema::Result::CdEvent>

=cut

__PACKAGE__->has_many(
  "cd_events",
  "MyApp::Schema::Result::CdEvent",
  { "foreign.cdid" => "self.cdid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tracks

Type: has_many

Related object: L<MyApp::Schema::Result::Track>

=cut

__PACKAGE__->has_many(
  "tracks",
  "MyApp::Schema::Result::Track",
  { "foreign.cdid" => "self.cdid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-21 16:25:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UEQUHWOActExPrID6T2meQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
