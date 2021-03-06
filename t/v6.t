#!/usr/bin/env perl6

use v6;
use Test;

use lib:from<Perl5> <t/lib>;
use TestV6:from<Perl5>;
use TestV6Sub:from<Perl5>;

is(Foo::Bar::TestV6::greet('world'), 'hello world');
is(Foo::Bar::TestV6.new('nice', name => 'world').hello, 'hello nice world');
is(
    EVAL(q/Foo::Bar::TestV6->create(foo => 'bar', v6::named name => 'world')/, :lang<Perl5>).hello,
    'hello bar world',
);
is(Foo::Bar::TestV6.new.context, 'array');
is(Foo::Bar::TestV6.new.test_scalar_context, 'scalar');
is(Foo::Bar::TestV6.new.test_array_context, 'array');
is(Foo::Bar::TestV6.new.test_call_context, 'array');
is(Foo::Bar::TestV6.new.test_isa, 1);
is(Foo::Bar::TestV6.new('bar').test_can, 1, "can finds the base class' methods");
is(Foo::Bar::TestV6.new('bar').test_can_subclass, 2, "can finds the subclass' methods");
is(Foo::Bar::TestV6.new('bar').test_package_can, 1, "can finds the base class' methods via package");
is(Foo::Bar::TestV6.new('bar').test_package_can_subclass, 2, "can finds the subclass' methods via package");
is(Foo::Bar::TestV6.new('bar').foo, 'bar');
is(Foo::Bar::TestV6.new('bar').get_foo, 'bar');
is(Foo::Bar::TestV6.new('bar').get_foo_indirect, 'bar');
is(Foo::Bar::TestV6.new.test_breaking_encapsulation(Foo::Bar::TestV6.new('bar')), 'bar');

is(
    EVAL(q/Foo::Bar::TestV6Sub->create(foo => 'bar', v6::named name => 'world')/, :lang<Perl5>).hello,
    'hello bar world',
);
ok(
    EVAL(q/Foo::Bar::TestV6Sub->create(foo => 'bar', name => 'world')->isa('Foo::Bar::TestV6Sub')/, :lang<Perl5>),
    'P5 subclass of P6 extended P5 class isa P5 subclass',
);

done;

# vim: ft=perl6
