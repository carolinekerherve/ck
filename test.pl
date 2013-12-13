use strict;
use warnings;

#use lib 'override';
use lib 'MT-3.2-en_US/lib';

use MT::Builder;
use MT::Template::Context;


my $build = MT::Builder->new;
my $ctx = MT::Template::Context->new;
$ctx->register_handler(Include => sub {
    my($arg, $cond) = @_[1,2];
    if (my $tmpl_name = $arg->{module}) {
        my $path = $tmpl_name;
        local *FH;
        open FH, $path
            or return $_[0]->error(MT->translate(
                "Error opening included file '[_1]': [_2]", $path, $! ));
        my $c = '';
        local $/; $c = <FH>;
        close FH;
        my $text = $c;

        my $tokens = $build->compile($ctx, $text)
            or return $_[0]->error(MT->translate(
                "Parse error in template '[_1]': [_2]",
                $path, $build->errstr));

        my $res = $build->build($ctx, $tokens, $cond);
        if (!defined $res) {
            return $_[0]->error(MT->translate(
                "Build error in template '[_1]': [_2]",
                $path, $build->errstr));

        }
        return $res;
    }
    else {
        die "not supported, this is a hack";
    }
});

my $tokens = $build->compile($ctx, '<$MTVersion$><$MTInclude module="navigation-bar"$>')
    or die $build->errstr;
defined(my $out = $build->build($ctx, $tokens))
    or die $build->errstr;

warn $out;
