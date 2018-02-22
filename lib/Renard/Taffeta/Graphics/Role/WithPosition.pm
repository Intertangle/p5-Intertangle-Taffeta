use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithPosition;
# ABSTRACT: A role that gives a position to a graphics object

use Moo::Role;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Yarn::Types qw(Point);

=attr position

A C<Renard::Yarn::Graphene::Point> representing the top-left position for a
graphics object.

=cut
has position => (
	is => 'ro',
	isa => Point,
	coerce => 1,
	required => 1,
);

1;
