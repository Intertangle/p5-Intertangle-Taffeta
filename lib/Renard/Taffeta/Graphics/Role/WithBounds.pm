use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithBounds;
# ABSTRACT: A role for the bounds of a graphic object

use Moo::Role;
use Renard::Yarn::Graphene;

use Renard::Incunabula::Common::Types qw(InstanceOf);

=attr bounds

A C<Renard::Yarn::Graphene::Rect> that represents the bounds of this graphics
object.

=cut
has bounds => (
	is => 'lazy', # _build_bounds
	isa => InstanceOf['Renard::Yarn::Graphene::Rect'],
);

method _build_bounds() {
	Renard::Yarn::Graphene::Rect->new(
		origin => $self->origin,
		size   => $self->size,
	);
}

=attr origin

A C<Renard::Yarn::Graphene::Point> that represents the origin of this graphics
object.

=cut
has origin => (
	is => 'ro',
	isa => InstanceOf['Renard::Yarn::Graphene::Point'],
	default => sub { Renard::Yarn::Graphene::Point->new( x => 0, y => 0 ) },
);

=attr size

A C<Renard::Yarn::Graphene::Size> that represents the size of this graphics
object.

=cut
has size => (
	is => 'lazy', # _build_size
	isa => InstanceOf['Renard::Yarn::Graphene::Size'],
);

1;
