use utf8;
package MyApp::Schema::Result::Employee;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Employee

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

=head1 TABLE: C<employee>

=cut

__PACKAGE__->table("employee");

=head1 ACCESSORS

=head2 employee_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 ee_number

  data_type: 'text'
  is_nullable: 0

=head2 first_name

  data_type: 'text'
  is_nullable: 0

=head2 last_name

  data_type: 'text'
  is_nullable: 0

=head2 address

  data_type: 'text'
  is_nullable: 0

=head2 last_info_change_id

  data_type: 'integer'
  default_value: -1
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "employee_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "ee_number",
  { data_type => "text", is_nullable => 0 },
  "first_name",
  { data_type => "text", is_nullable => 0 },
  "last_name",
  { data_type => "text", is_nullable => 0 },
  "address",
  { data_type => "text", is_nullable => 0 },
  "last_info_change_id",
  {
    data_type      => "integer",
    default_value  => -1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</employee_id>

=back

=cut

__PACKAGE__->set_primary_key("employee_id");

=head1 RELATIONS

=head2 employee_events

Type: has_many

Related object: L<MyApp::Schema::Result::EmployeeEvent>

=cut

__PACKAGE__->has_many(
  "employee_events",
  "MyApp::Schema::Result::EmployeeEvent",
  { "foreign.employee_id" => "self.employee_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 last_info_change

Type: belongs_to

Related object: L<MyApp::Schema::Result::EmployeeEvent>

=cut

__PACKAGE__->belongs_to(
  "last_info_change",
  "MyApp::Schema::Result::EmployeeEvent",
  { employee_event_id => "last_info_change_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-07-23 08:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KqPqfkFJtxKoeSOvUqEzUQ

__PACKAGE__->load_components( qw/ Events / );

# A different name can be used with the "events_relationship" attribute
__PACKAGE__->has_many(
    'events' => ( 'MyApp::Schema::Result::EmployeeEvent', 'employee_id' ),
    { cascade_delete => 0 },
);

__PACKAGE__->has_one(
    'last_info_change'        => 'MyApp::Schema::Result::EmployeeEvent',
    { 'foreign.employee_event_id' => 'self.last_info_change_id' },
    { cascade_delete          => 0 },
);

sub change_last_name {
    my ( $self, $new_last_name ) = @_;

    my $event = $self->event( ee_info_change =>
        { details => { new => $new_last_name, old => $self->last_name } } );
    $self->last_info_change( $event );
    # $self->update; # be lazy and make our caller call ->update
    $self->last_name( $new_last_name );
}
sub change_first_name {
    my ( $self, $new_first_name ) = @_;

    my $event = $self->event( ee_info_change =>
        { details => { new => $new_first_name, old => $self->first_name } } );
    $self->last_info_change( $event );
    # $self->update; # be lazy and make our caller call ->update
    $self->first_name( $new_first_name );
}
sub change_address {
    my ( $self, $new_address ) = @_;

    my $event = $self->event( ee_info_change =>
        { details => { new => $new_address, old => $self->address } } );
    $self->last_info_change( $event );
    # $self->update; # be lazy and make our caller call ->update
    $self->address( $new_address );
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
