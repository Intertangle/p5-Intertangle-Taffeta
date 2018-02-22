use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Types;
# ABSTRACT: Types for Taffeta

use Type::Library 0.008 -base,
	-declare => [qw(
		CairoContext
		SVG

		ColorLibrary
		RGB24Value
		RGBFloatComponentValue
		Color

		Opacity
		Dimension
	)];
use Type::Utils -all;
use Types::Standard qw(Str);
use Types::Common::Numeric qw(PositiveOrZeroInt PositiveOrZeroNum);

use Color::Library;

=type CairoContext

A type for any reference that extends L<Cairo::Context>.

=cut
class_type "CairoContext",
	{ class => 'Cairo::Context' };

=type SVG

A type for any reference that extends L<SVG>.

=cut
class_type "SVG",
	{ class => "SVG" };

=type ColorLibrary

A type for any reference that extends L<Color::Library::Color>

Coercible from a C<Str> such as C<svg:blue>.

=cut
class_type "ColorLibrary",
	{ class => 'Color::Library::Color' };

coerce "ColorLibrary",
	from Str, via { Color::Library->color($_) };

=type RGB24Value

A valid RGB value between 0 and 0xFFFFFF.

=cut
declare RGB24Value =>
	as PositiveOrZeroInt,
	where { $_ <= 0xFFFFFF };

=type RGBFloatComponentValue

A type for a C<Num> that falls in the range for a RGB float component value.

=cut
declare RGBFloatComponentValue =>
	as PositiveOrZeroNum,
	where { $_ <= 1.0 };

=type Color

A type for any reference that extends L<Renard::Taffeta::Color>.

=cut
class_type "Color",
	{ class => 'Renard::Taffeta::Color' };

=type Opacity

A type for a C<Num> that falls in the range for an opacity value.

=cut
declare Opacity =>
	as PositiveOrZeroNum,
	where { $_ <= 1.0 };

=type Dimension

A type for a C<Num> that can represent a dimension.

=cut
declare Dimension =>
	as PositiveOrZeroNum;

1;
