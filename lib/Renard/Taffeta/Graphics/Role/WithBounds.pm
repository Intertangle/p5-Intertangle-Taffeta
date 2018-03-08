use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithBounds;
# ABSTRACT: A role for the bounds of a graphic object

use Moo::Role;
use Renard::Yarn::Graphene;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Yarn::Types qw(Point Size);

=attr identity_bounds

A C<Renard::Yarn::Graphene::Rect> that represents the bounds of this graphics
object when the transform is the identity matrix.

=cut
has identity_bounds => (
	is => 'lazy', # _build_identity_bounds
	isa => InstanceOf['Renard::Yarn::Graphene::Rect'],
);

method _build_identity_bounds() {
	Renard::Yarn::Graphene::Rect->new(
		origin => $self->origin,
		size   => $self->size,
	);
}

=attr origin

A C<Point> that represents the origin of this graphics
object.

The default is at C<(0, 0)>.

=cut
has origin => (
	is => 'ro',
	isa => Point,
	coerce => 1,
	default => sub { Renard::Yarn::Graphene::Point->new( x => 0, y => 0 ) },
);

=attr size

A C<Size> that represents the size of this graphics
object.

=cut
has size => (
	is => 'lazy', # _build_size
	isa => Size,
);

1;
