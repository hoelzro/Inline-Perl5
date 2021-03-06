#!/usr/bin/env perl6

use v6;
use Inline::Perl5;
use Test;

my $p5 = Inline::Perl5.new;

$p5.run: q:heredoc/PERL5/;
    package Foo;
    use overload '""' => sub {
            my ($self) = @_;

            return $$self;
        };

    sub new {
        my ($class, $str) = @_;
        return bless \$str, $class;
    }

    package Bar;
    sub new {
        my ($class, $str) = @_;
        return bless \$str, $class;
    }
    PERL5

my $foo = $p5.invoke('Foo', 'new', 'a string!');
is("$foo", 'a string!');
unlike("$foo", /Perl5Object\<\d+\>/);

my $bar = $p5.invoke('Bar', 'new', 'a string!');
isnt("$bar", 'a string!');
like("$bar", /Perl5Object\<\d+\>/);

done;

# vim: ft=perl6
