use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithStroke;
# ABSTRACT: A role for a fill style

use Moo::Role;
use Renard::Incunabula::Common::Types qw(InstanceOf);

=attr stroke

A L<Renard::Taffeta::Style::Stroke> style to stroke the shape.

=method has_stroke

Predicate for C<stroke> attribute.

=cut
has stroke => (
	is => 'ro',
	predicate => 1,
	isa => InstanceOf['Renard::Taffeta::Style::Stroke'],
);

1;
