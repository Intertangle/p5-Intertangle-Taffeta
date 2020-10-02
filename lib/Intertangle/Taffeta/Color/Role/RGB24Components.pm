use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Color::Role::RGB24Components;
# ABSTRACT: RGB component colour role

use Moo::Role;
use MooX::ShortHas;
use namespace::autoclean;
use Intertangle::Taffeta::Types qw(RGB24Value RGB24Component);

=attr value

A C<RGB24Value>.

=cut
requires 'value';

=attr r8

Red component as C<RGB24Component>.

=cut
lazy r8 => method() { ($self->value & 0xFF0000) >> 16; }, isa => RGB24Component;

=attr g8

Green component as C<RGB24Component>.

=cut
lazy g8 => method() { ($self->value & 0x00FF00) >>  8; }, isa => RGB24Component;

=attr b8

Blue component as C<RGB24Component>.

=cut
lazy b8 => method() { ($self->value & 0x0000FF) >>  0; }, isa => RGB24Component;

=method rgb_float_triple

Returns a list of the float components C<(r_float, g_float, b_float)>.

=cut
method rgb_float_triple() {
	($self->r8 / 0xFF, $self->g8 / 0xFF, $self->b8 / 0xFF );
}

1;
