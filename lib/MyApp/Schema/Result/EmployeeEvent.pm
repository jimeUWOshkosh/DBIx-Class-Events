use utf8;
package MyApp::Schema::Result::EmployeeEvent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::EmployeeEvent

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

=head1 TABLE: C<employee_event>

=cut

__PACKAGE__->table("employee_event");

=head1 ACCESSORS

=head2 employee_event_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 employee_id

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
  "employee_event_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "employee_id",
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

=item * L</employee_event_id>

=back

=cut

__PACKAGE__->set_primary_key("employee_event_id");

=head1 RELATIONS

=head2 employee

Type: belongs_to

Related object: L<MyApp::Schema::Result::Employee>

=cut

__PACKAGE__->belongs_to(
  "employee",
  "MyApp::Schema::Result::Employee",
  { employee_id => "employee_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 employees

Type: has_many

Related object: L<MyApp::Schema::Result::Employee>

=cut

__PACKAGE__->has_many(
  "employees",
  "MyApp::Schema::Result::Employee",
  { "foreign.last_info_change_id" => "self.employee_event_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-18 18:35:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LOVYhnSi5oDdfIx4KCS1JA

use JSON::PP ();
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
    'employee' => ( 'MyApp::Schema::Result::Employee', 'employee_id' ) );



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
