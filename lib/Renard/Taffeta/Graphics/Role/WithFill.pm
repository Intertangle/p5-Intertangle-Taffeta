use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithFill;
# ABSTRACT: A role for a fill style

use Moo::Role;
use Renard::Incunabula::Common::Types qw(InstanceOf);

=attr fill

A L<Renard::Taffeta::Style::Fill> style to fill the shape.

=method has_fill

Predicate for C<fill> attribute.

=cut
has fill => (
	is => 'ro',
	predicate => 1,
	isa => InstanceOf['Renard::Taffeta::Style::Fill'],
);

1;
