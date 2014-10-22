#!/usr/bin/env perl
# -*- cperl -*-

# $Id: xsh,v 2.1 2004/12/02 19:26:35 pajas Exp $

use FindBin;
use lib ("$FindBin::RealBin", "$FindBin::RealBin/../lib",
         "$FindBin::Bin","$FindBin::Bin/../lib",
	 "$FindBin::Bin/lib", "$FindBin::RealBin/lib"
	);

package main;

use strict;

#use Getopt::Std;
use Getopt::Long;
use Pod::Usage;
use vars qw($opt_q $opt_w $opt_i $help $opt_V $opt_E $opt_e $opt_d
            $opt_c $opt_s $opt_f $opt_g $opt_v $opt_t $opt_T $opt_a
            $opt_l $opt_n $opt_p $opt_P $usage $manpage $opt_HTML
            $opt_XML $input $output $process $format $opt_C);
use vars qw($VERSION $REVISION);

use IO::Handle;

use XML::XSH2 qw(&xsh_set_output &xsh_get_output &xsh &xsh_init
		&xsh_pwd &set_quiet &set_debug &xsh_context_var
		&set_compile_only_mode &xsh_set_script);

BEGIN {
  my $optparser=new Getopt::Long::Parser(config => ["bundling"]);
  $optparser->getoptions(
			 "arguments|a" => \$opt_a,
			 "stdin|t" => \$opt_t,
			 "compile|c" => \$opt_c,
			 "quiet|q" => \$opt_q,
			 "validation|v" => \$opt_v,
			 "format" => \$format,
			 "no-validation|w" => \$opt_w,
			 "debug|d" => \$opt_d,
			 "no-init|f" => \$opt_f,
			 "help|h" => \$help,
			 "version|V" => \$opt_V,
			 "interactive|i" => \$opt_i,
			 "input|I=s" => \$input,
			 "output|O=s" => \$output,
			 "commands|C" => \$opt_C,
			 "process|P=s" => \$process,
			 "non-interactive|n" => \$opt_n,
			 "pipe|p" => \$opt_p,
			 "html|H" => \$opt_HTML,
			 "xml|X" => \$opt_XML,
			 "trace-grammar|T" => \$opt_T,
			 "benchmark|B" => \$XML::XSH2::Functions::BENCHMARK,
			 "query-encoding|E=s" => \$opt_E,
			 "encoding|e=s" => \$opt_e,
			 "load|l=s" => \$opt_l,
			 "usage|u"        => \$usage,
			 "man"        => \$manpage,
			) or $usage=1;
#  getopts('atscqvwdfhVinTE:e:l:pP');
  $VERSION='0.12';
   $REVISION=q($Revision: 2.1 $);
  $ENV{PERL_READLINE_NOWARN}=1;
}

if ($opt_P and ($input or $output)) {
  print STDERR "Options -P is incompatible with -I and -O!\n";
  $usage=1;
}

# Help and usage
if ($usage) {
  pod2usage(-msg => 'xsh - XML Editing Shell');
#  exit 0;
}
if ($help) {
  pod2usage(-exitstatus => 0, -verbose => 1);
}
if ($manpage) {
  pod2usage(-exitstatus => 0, -verbose => 2);
}

die "Incompatible options: -a, -C\n" if $opt_a+$opt_C > 1;

my $string;
if (!$opt_C and !$opt_a and $opt_l eq "" and -f $ARGV[0]) {
  # suppose the 1st argument is a script,
  # and the rest is its parameters
  $opt_l = shift @ARGV;
  @XML::XSH2::Map::ARGV=@ARGV;
} elsif ($opt_a) {
  @XML::XSH2::Map::ARGV=@ARGV;
} else {
  # suppose the arguments are XSH commands
  $string=join " ",@ARGV;
}

die "Incompatible options: --html, --xml\n" if $opt_XML+$opt_HTML > 1;
if ($opt_HTML) {
  $XML::XSH2::Functions::DEFAULT_FORMAT='html';
} elsif ($opt_XML) {
  $XML::XSH2::Functions::DEFAULT_FORMAT='xml';
}

if ($opt_p) {
  $opt_n=1;
  $opt_i=0;
  $opt_t=0;
}

unless ($opt_n || $opt_i) {
  $opt_i=((-t STDIN) && !$opt_l && !$string) ? 1 : 0;
}

require Term::ReadLine if $opt_i;

if ($opt_V) {
  my $rev=$REVISION;
  $rev=~s/\s*\$//g;
  my $funcrev=$XML::XSH2::Functions::REVISION;
  $funcrev=~s/\s*\$//g;
  print "xsh $VERSION ($rev)\n";
  print "XML::XSH2::Functions $XML::XSH2::Functions::VERSION ($funcrev)\n";
  exit 1;
}

$::RD_ERRORS = 1; # Make sure the parser dies when it encounters an error
$::RD_WARN   = 1; # Enable warnings. This will warn on unused rules &c.
$::RD_HINT   = 1; # Give out hints to help fix problems.
$::RD_TRACE   = $opt_T; # Give out hints to help fix problems.

my $module;
#if ($opt_g) {
#  $module="XML::XSH2::GDOMECompat";
#} else {
  $module="XML::XSH2::LibXMLCompat";
#}
xsh_init($module);
XML::XSH2::Functions::set_encoding($opt_e) if $opt_e;
XML::XSH2::Functions::set_qencoding($opt_E) if $opt_E;
set_quiet($opt_q);
set_debug($opt_d);
set_compile_only_mode($opt_c);

my $doc=XML::XSH2::Functions::create_doc('$scratch',"scratch",'xml');
XML::XSH2::Functions::set_local_xpath('/');

# XPath variant of perlish {@ARGV} ($ARGV[1] is the first arg though)
$XML::XSH2::Map::ARGV = XML::LibXML::NodeList->new(map { XML::XSH2::Functions::cast_value_to_objects($_) } @XML::XSH2::Map::ARGV);

if ($opt_w) {
  XML::XSH2::Functions::set_validation(0);
  XML::XSH2::Functions::set_load_ext_dtd(0);
  XML::XSH2::Functions::set_expand_entities(0);
  XML::XSH2::Functions::set_complete_attributes(0);
} elsif ($opt_v) {
  XML::XSH2::Functions::set_validation(1);
  XML::XSH2::Functions::set_load_ext_dtd(1);
  XML::XSH2::Functions::set_expand_entities(1);
  XML::XSH2::Functions::set_complete_attributes(1);
}

if ($format) {
  XML::XSH2::Functions::set_keep_blanks(0);
  XML::XSH2::Functions::set_indent(1);
  print "FORMAT: $XML::XSH2::Map::INDENT $XML::XSH2::Map::KEEP_BLANKS\n";
}

my $l;

unless ($opt_f) {
  eval {
    my $ini = "$ENV{HOME}/.xsh2rc";
    if (-r $ini) {
      open my $INI, '<:bytes',$ini || die "cannot open $ini";
      $XML::XSH2::Functions::_includes{$ini}=1;
      xsh_set_script($ini);
      xsh(join("",<$INI>));
      close $INI;
    }
  };
  if ($@) {
    print STDERR "Error occured while reading ~/.xsh2rc\n";
    print STDERR "$@\n";
  }
}

if ($opt_i) {
  $XML::XSH2::Functions::TRAP_SIGINT=1;
  $XML::XSH2::Functions::TRAP_SIGPIPE=1;
  $XML::XSH2::Functions::_die_on_err=0;
  unless ($opt_q) {
    my $rev=$REVISION;
    $rev=~s/\s*\$//g;
    $rev=" xsh - XML Editing Shell version $XML::XSH2::Functions::VERSION/$VERSION ($rev)\n";
    print STDERR "-"x length($rev),"\n";
    print STDERR $rev;
    print STDERR "-"x length($rev),"\n\n";
    print STDERR "Copyright (c) 2002 Petr Pajas.\n";
    print STDERR "This is free software, you may use it and distribute it under\n";
    print STDERR "either the GNU GPL Version 2, or under the Perl Artistic License.\n";
  }
} else {
  $XML::XSH2::Functions::_die_on_err=1;
}

if ($process ne "") {
  $input=$process;
  $output=$process;
}

if ($opt_p) {
  $input  ||= '-';
  $output ||= '-';
}

foreach ($input, $output) {
  s(\\)(\\\\)g;
  s(')(\\')g;
}

print STDERR "\$INPUT open := '$input'\n" if $opt_d;
xsh_set_script('<CMD-LINE>');
xsh("\$INPUT := open '$input'") if ($input);

if ($opt_l) {
  open(my $load,'<:bytes',"$opt_l") || do { print STDERR "Error loading $opt_l: $!\n"; exit 1 };
  xsh_set_script($opt_l);
  my $s = join "",<$load>;
  close $load;
  xsh($s);
}

if ($string) {
  print "xsh> $string\n" if ($opt_i and not $opt_q);
  xsh_set_script('<CMD-LINE>');
  xsh($string);
  print "\n" if ($opt_i and not $opt_q);
}


my $term;
sub _term { $term };

if ($opt_i) {
  $term = new Term::ReadLine('xsh');
  $XML::XSH2::Functions::_on_exit=
    [sub { 
       my ($exit_code,$term)=@_;
       if ($term->can('GetHistory')) {
	 eval {
	   print STDERR "saving $ENV{HOME}/.xsh_history\n";
	   open my $HIST,'>:bytes',"$ENV{HOME}/.xsh_history" || die "cannot open $ENV{HOME}/.xsh_history";
	   print $HIST join("\n",$term->GetHistory());
	   close $HIST;
	   print STDERR "done\n";
	 };
	 if ($@) {
	   print STDERR "Error occured while writing to ~/.xsh_history\n";
	   print STDERR "$@\n";
	 }
       }
     },$term
    ];

  eval {
    if (-r "$ENV{HOME}/.xsh_history") {
      open my $HIST,'<:bytes',"$ENV{HOME}/.xsh_history";
      $term->addhistory(map { chomp; $_ } <$HIST>);
      close $HIST;
    }
  };
  if ($@) {
    print STDERR "Error occured while reading from ~/.xsh_history\n";
    print STDERR "$@\n";
  }

#  XML::XSH2::Completion::cpl();
  if ($term->ReadLine eq "Term::ReadLine::Gnu") {
    $term->Attribs->{attempted_completion_function} = \&XML::XSH2::Completion::gnu_complete;
    $term->Attribs->{completion_entry_function} = sub { return () };
    $term->Attribs->{completer_word_break_characters} = " =\t\n\r\"'`;|&})[{(]";
    $term->Attribs->{horizontal_scroll_mode} = 0;
  } else {
    $readline::rl_completion_function = 'XML::XSH2::Completion::perl_complete';
    $readline::rl_completer_word_break_characters = " =\t\n\r\"'`;|&})[{(]";
  }

  xsh_set_output($term->OUT) if ($term->OUT);
  unless ("$opt_q") {
    print STDERR "Using terminal type: ",$term->ReadLine,"\n";
      print STDERR "Hint: Type `help' or `help | less' to get more help.\n";
  }
  while (defined ($l=get_line($term,prompt(),''))) {
    while ($l=~/\\+\s*$/) {
      $l=~s/\\+(\s*)$/\n/;
      my $a=get_line($term,'> ',undef);
      if (defined($a)) {
	$l.=$a
      } else {
	$l='';
      }
    }
    if ($l=~/\S/) {
      xsh_set_script('<STDIN>');
      eval { xsh($l); };
      warn $@ if $@;
#      $term->addhistory($l);
    }
  }
  print STDERR "Good bye!\n" if $opt_i and not "$opt_q";
} elsif ((!$opt_p and $string eq "" and $opt_l eq "") or $opt_t) {
  xsh_set_script('<STDIN>');
  binmode STDIN,':bytes';
  my $s = join "",<STDIN>;
  close STDIN;
  xsh($s);
}

xsh_set_script('<CMD-LINE>');
if ($output) {
  local $XML::XSH2::Map::OUTFILE=$output;
  xsh('save --file $OUTFILE $INPUT');
}

# get a line of input from ReadLine
# if ^C interruption by user occures return $retonint
#
sub get_line {
  my ($term,$prompt,$retonint)=@_;
  my $line;
  $SIG{INT}=sub { die 'TRAP-SIGINT'; };
  eval {
    $line = $term->readline($prompt);
  };
  if ($@) {
    if ($@ =~ /TRAP-SIGINT/) {
      print "\n" unless $term->ReadLine eq 'Term::ReadLine::Perl'; # clear screen
      return $retonint;
    } else {
      print STDERR $@,"\n";
      return undef;
    }
  }
  return $line;
}

sub prompt {
  return xsh_context_var().xsh_pwd().'> ';
}


__END__

=pod

=head1 xsh

xsh - XML Editing Shell

=head1 SYNOPSIS

  xsh [options] script_or_command
  xsh [options] -al script [arguments ...]
  xsh [options] -p commands < input.xml > output.xml
  xsh [options] -I input.xml -O output.xml commands
  xsh [options] -P file.xml commands

  xsh -u          for usage
  xsh -h          for help
  xsh --man       for the manual page

=head1 DESCRIPTION

XSH is an shell-like language for XPath-oriented editing, querying and
manipulation of XML and HTML files (with read-only support for DocBook
SGML). C<xsh> can work as an interactive shell (with full command-line
support such as history, TAB-completion, etc.) or as an off-line
interpreter for batch processing of XML files.

=head1 XSH COMMANDS

Please see L<http://xsh.sourceforge.net/doc/frames/index.html> or
L<XSH> for a complete XSH language reference.

For a quick help, type C<xsh help> (just C<help> on xsh prompt).

Type C<xsh help commands> to get list of available XSH commands and
C<xsh help B<command>> with B<command> replaced by a XSH command name
to get help on a particular command.

=head1 OPTIONS

=over 8

=item B<--load|-l> script-file

Load and execute given XSH script (the script is executed before all
other commands provided on the command-line, but after executed
~/.xsh2rc).

=item B<--commands|-C>

Indicate, that the command-line arguments are XSH commands.

=item B<--arguments|-a>

Indicate, that the command-line arguments are should be
passed to the script via C<@XML::XSH2::Map::ARGV>. This
option is incompatible with C<--commands>.

=item B<--stdin|-t>

Don't display command-prompt even if run from a terminal, expecting
XSH commands in the standard input.

=item B<--compile|-c>

Compile the XSH source and report errors, only. No commands are
actually executed.

=item B<--quiet|-q>

Quiet mode: suppress all unnecessary informatory ouptut.

=item B<--format>

Start with indent 1 (on) and keep_blanks 0 (off)
to allow nice indenting of the XML output.

=item B<--validation|-v>

Start with validation, load_ext_dtd, parser_expands_entities
and parser_completes_attributes 1 (on).

=item B<--no-validation|-w>

Start with validation, load_ext_dtd, parser_expands_entities
and parser_completes_attributes 0 (off).

=item B<--debug|-d>

Print some debug messages.

=item B<--no-init|-f>

Ignore ~/.xsh2rc

=item B<--version|-V>

Print XSH version info and exit.

=item B<--interactive|-i>

Start interactive mode with xsh command prompt. By default, the
interactive mode is only started if C<xsh> is running from a terminal
and neither XSH commands nor a script are given on the command-line.

=item B<--non-interactive|-n>

Force non-interactive mode.

=item B<--pipe|-p>

This is a special mode in which xsh acts as a pipe-line processing
tool.  In this mode, first the standard input is read and opened as a
document _ (underscore), then all XSH commands given in ~/.xsh2rc,
command-line and given XSH scripts are applied and finally the
(possibly modified) document _ is dumped back on the standard output.
It is equivallent to C<-I - -O -> and C<-P ->.

=item B<--input|-I> filename

Preload given file as a document with ID _ upon startup.

=item B<--output|-O> filename

Try to saves document with ID _ into given file before XSH ends.

=item B<--process|-P> filename

A convenient shortcut for C<-I filename -O filename>.

=item B<--html|-H>

Make XSH expect HTML documents by default in all open/save operations.

=item B<--xml|-X>

This option is included only for completeness sake.
Make XSH expect XSH documents by default in all open/save operations
(this is the default).

=item B<--trace-grammar|-T>

This option allows tracing the way XSH language parser processes your
script.

=item B<--query-encoding|-E> encoding

Set the encoding that used in the XSH scripts (or keyboard input).

=item B<--encoding|-e> encoding

Set the encoding that should be used for XSH output.

=item B<--usage|-u>

Print a brief help message on usage and exits.

=item B<--help|-h>

Prints the help page and exits.

=item B<--man>

Displays the help as manual page.

=back

=head1 AUTHOR

Petr Pajas <pajas@matfyz.cz>

Copyright 2000-2003 Petr Pajas, All rights reserved.

