use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Color::Role::SVG;
# ABSTRACT: SVG colour role

use Mu::Role;

requires 'r8';
requires 'g8';
requires 'b8';

lazy svg_value => method() {
	"rgb(@{[ $self->r8 ]},@{[ $self->g8 ]},@{[ $self->b8 ]})";
};

1;
