use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Types;
# ABSTRACT: Types for Taffeta

use Type::Library 0.008 -base,
	-declare => [qw(
		CairoContext
		SVG
	)];
use Type::Utils -all;

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


1;
