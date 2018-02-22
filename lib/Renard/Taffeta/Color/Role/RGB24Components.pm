use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Color::Role::RGB24Components;
# ABSTRACT: RGB component colour role

use Moo::Role;
use MooX::ShortHas;
use namespace::autoclean;

requires 'value';

lazy r8 => method() { ($self->value & 0xFF0000) >> 16; };
lazy g8 => method() { ($self->value & 0x00FF00) >>  8; };
lazy b8 => method() { ($self->value & 0x0000FF) >>  0; };

method rgb_float_triple() {
	($self->r8 / 0xFF, $self->g8 / 0xFF, $self->b8 / 0xFF );
}

1;
