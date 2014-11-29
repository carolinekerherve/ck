use strict;
use warnings;

#use lib 'override';
use lib 'MT-3.2-en_US/lib';

use Data::Dumper;
use MT;
use MT::Builder;
use MT::Template::Context;

MT->set_language('en_US');

my $build = MT::Builder->new;
my $ctx = MT::Template::Context->new;
my $entry = MT::Entry->new;
$entry->id(1);
$entry->blog_id(3);
$entry->status(MT::Entry::RELEASE());
$entry->author_id(2);
$entry->title('My title');
$entry->text('Some text');


$ctx->stash(entry => $entry);

sub slurp {
    my $fn = shift;
    open my $fh, "<", $fn;
    my $data = do { local $/; <$fh> };
    close $fh;
    return $data;
}

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

$ctx->register_handler(PostPageTitle => sub {
    return "PAGE TITLE~~";
});
$ctx->register_handler(EntryId => sub {
    return "entryid";
});
$ctx->register_handler(EntryBody => sub {
    return "This is the body of the entry";
});
$ctx->register_handler(EntryDate => sub {
    return "2014-01-01 13:32";
});
$ctx->register_handler(Trans => sub {
    my $tmpl = $_[1]->{phrase};
    return $tmpl;
});
$ctx->register_handler(EntryIfCategories => [ sub {
    return MT::Template::Context::_hdlr_pass_tokens_else(@_);
}, 2]);
$ctx->register_handler(EntryCategories => sub {
    return "";
});
$ctx->register_handler(EntryCategoryId => sub {
    return 1;
});
$ctx->register_handler(CategoryLabel => sub {
    return "category";
});
$ctx->register_handler(EntryIfTagged => [sub { return MT::Template::Context::_hdlr_pass_tokens_else(@_);
        }, 2]);
$ctx->register_handler(TechnoratiDomain => sub { '' });
$ctx->register_handler(CategoryArchiveLink => sub { "" });
$ctx->register_handler(EntryPermalink => sub { "http://localhost:5000/entry" });

$ctx->register_handler(EntryTags => sub { "" });
$ctx->register_handler(TagLabelClean => sub { "" });
$ctx->register_handler(TagLabel => sub { "" });
$ctx->register_handler(BlogName => sub { "Caroline's blog" });


my $data = slurp($ARGV[0]);

my $tokens = $build->compile($ctx, $data)
    or die $build->errstr;
defined(my $out = $build->build($ctx, $tokens))
    or die $build->errstr;

open my $fh, ">", $ARGV[0];
print $fh $out;
close $fh;
