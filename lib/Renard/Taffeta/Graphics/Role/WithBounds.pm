use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithBounds;
# ABSTRACT: A role for the bounds of a graphic object

use Moo::Role;

use Renard::Incunabula::Common::Types qw(InstanceOf);

=attr bounds

A C<Renard::Yarn::Graphene::Size> that represents the bounds of this graphics
object.

=cut
has bounds => (
	is => 'lazy', # _build_bounds
	isa => InstanceOf['Renard::Yarn::Graphene::Size'],
);

1;
