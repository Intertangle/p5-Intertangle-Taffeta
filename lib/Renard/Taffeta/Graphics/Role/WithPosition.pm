use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithPosition;
# ABSTRACT: A role that gives a position to a graphics object

use Moo::Role;

use Renard::Incunabula::Common::Types qw(InstanceOf);

=attr position

A C<Renard::Yarn::Graphene::Point> representing the top-left position for a
graphics object.

=cut
has position => (
	is => 'ro',
	isa => InstanceOf['Renard::Yarn::Graphene::Point'],
	required => 1,
);

1;
