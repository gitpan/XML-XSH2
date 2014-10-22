# -*- cperl -*-
use Test;

use IO::File;

BEGIN {
  autoflush STDOUT 1;
  autoflush STDERR 1;

  @xsh_test=split /\n\n/, <<'EOF';
quiet;
def p_assert $cond
  {
   eval 'unless {${cond}} throw "Assertion failed ${cond}"';
  }

$a=5;
p_assert '$a == 5';

try {
  call p_assert '$a == 3';
  throw "p_assert failed";
} catch local $err {
  unless { $err =~ /^Assertion failed \$a == 3 at / } throw $err;
};


# Perl based foreach
foreach local $__ in { 1..3 } {
  $a = $__;
  last;
}

call p_assert '$a == 1';

foreach { 1..3 } {
  $b = 0;
  $a = string(.);
  next;
  $b = 1;
}
# echo $a | cat 1>&2;

call p_assert '$a == 3';

call p_assert '$b == 0';

$a=0; $b=1; $c=0;
foreach { 1..3 } {
  perl { $b = ($b+1) % 2 };
#  echo $a $b | cat;
  $a = $a+1;
  unless $b redo;
  $c = 1;
}

call p_assert '$a == 6';

call p_assert '$c == 1';

# XPATH based foreach
insert chunk "<a/><a/><a/>" into /scratch;
cd scratch;
$a = ""; $b = ""; $c = "";

ls;

$a=0;
foreach a {
  $a = $a+1;
  last;
}

call p_assert '$a == 1';

$a=0;
foreach a {
  $b = 0;
  $a = $a+1;
  next;
  $b = 1;
}

call p_assert '$a == 3';

call p_assert '$b == 0';

$a=0; $b=1; $c=0;
foreach a {
  perl { $b = ($b+1) % 2 };
  $a = $a+1;
  unless $b redo;
  $c = 1;
}

call p_assert '$a == 6';

call p_assert '$c == 1';

# Perl based while
$a=3;
while { $a } {
  $a = ($a - 1);
  last;
}

call p_assert '$a == 2';

$a=0; $b=2;
while { $a<3 } {
  $b = 0;
  $a = $a+1;
  next;
  $b = 1;
}

call p_assert '$a == 3';

call p_assert '$b == 0';

$i=0; $a=0; $b=1; $c=0;
while { $i++<3 } {
  perl { $b = ($b+1) % 2 };
#  echo $a $b $i | cat;
  $a = $a+1;
  unless $b redo;
  $c = 1;
}

call p_assert '$i == 4';

call p_assert '$a == 6';

call p_assert '$c == 1';

# XPATH based while
$a=3;
while ($a) {
  $a = ($a - 1);
  last;
}

call p_assert '$a == 2';

$a=0; $b=2;
while ( $a<3 ) {
  $b = 0;
  $a = $a+1;
  next;
  $b = 1;
}

call p_assert '$a == 3';

call p_assert '$b == 0';

$i=0; $a=0; $b=1; $c=0;
while ( $i<3 ) {
  perl { $b = ($b+1) % 2 };
#  echo $a $b $i | cat;
  $a = $a+1;
  unless $b redo;
  $i=$i+1;
  $c = 1;
}

call p_assert '$i == 3';

call p_assert '$a == 6';

call p_assert '$c == 1';
EOF

  plan tests => 4+@xsh_test;
}
END { ok(0) unless $loaded; }
use XML::XSH2 qw/&xsh &xsh_init &set_quiet &xsh_set_output/;
$loaded=1;
ok(1);

my $verbose=$ENV{HARNESS_VERBOSE};

($::RD_ERRORS,$::RD_WARN,$::RD_HINT)=(1,1,1);

$::RD_ERRORS = 1; # Make sure the parser dies when it encounters an error
$::RD_WARN   = 1; # Enable warnings. This will warn on unused rules &c.
$::RD_HINT   = 1; # Give out hints to help fix problems.

#xsh_set_output(\*STDERR);
set_quiet(0);
xsh_init();

print STDERR "\n" if $verbose;
ok(1);

print STDERR "\n" if $verbose;
ok ( XML::XSH2::Functions::create_doc("scratch","scratch") );

print STDERR "\n" if $verbose;
ok ( XML::XSH2::Functions::set_local_xpath('/') );

foreach (@xsh_test) {
  print STDERR "\n\n[[ $_ ]]\n" if $verbose;
  eval { xsh($_) };
  print STDERR $@ if $@;
  ok( !$@ );
}
