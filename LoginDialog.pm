package Tk::LoginDialog;
my $RCSRevKey = '$Revision: 0.61 $';
$RCSRevKey =~ /Revision: (.*?) /;
$VERSION=0.61;
use vars qw($VERSION @EXPORT_OK);

use Tk qw(Ev);
use strict;
use Carp;
use base qw(Tk::Toplevel);
use Tk::widgets qw(LabEntry DialogBox);

Construct Tk::Widget 'LoginDialog';

my $menufont="*-helvetica-medium-r-*-*-12-*";

sub Populate {
  my ($w, $args) = @_;
  require Tk::Toplevel;
  require Tk::DialogBox;
  require Tk::LabEntry;
  require Tk::Button;
  require Tk::Frame;
  $w->SUPER::Populate($args);

  my $l = $w -> Component( Label => 'toplabel',
			   -font => $menufont,
			   -text => 'Please enter your User ID and Password:'
			 ) -> pack( -expand => '1', -fill => 'x' );
  $l = $w -> Component( LabEntry => 'userid',
			 -labelVariable => \$w -> {'Configure'}{'-uidlabel'},
			 -labelFont => $menufont,
			 -textvariable => \$w -> {'Configure'}{'-userid'} )
    -> pack( -anchor => 'w', -expand => '1', -fill => 'x' );
  $l = $w -> Component( LabEntry => 'password',
			-labelVariable => \$w -> {'Configure'}{'-pwdlabel'},
			-labelFont => $menufont,
			-textvariable => \$w -> {'Configure'}{'-password'},
			-show => '*' )
    -> pack( -anchor => 'w', -expand => '1', -fill => 'x' );
  my $f = $w -> Component( Frame => 'buttons',
			   -container => '0',
			   -relief => 'groove',
			   -borderwidth => '3' );
  my $ok = $f -> Button( -text => 'Login', -width => 6,
			 -font => $menufont,
			 -default => 'active',
			 -command => sub{ $w->Accept})
    -> pack( -padx => 30, -pady => 5, -side => 'left', -anchor => 'w');
  my $cancel = $f -> Button( -text => 'Cancel', -width => 6,
			     -font => $menufont,
			     -default => 'normal',
			     -command =>sub{$w->WmDeleteWindow})
    -> pack( -padx => 30, -pady => 5, -side => 'right', -anchor => 'e' );
  $f -> pack( -ipadx => 10, -expand => '1', -fill => 'x' );
  $w->ConfigSpecs(
		-userid   => ['PASSIVE', undef, undef, "" ],
		-password => ['PASSIVE', undef, undef, "" ],
		  -accept => ['PASSIVE', undef, undef, "" ],
		-uidlabel => ['PASSIVE', undef, undef, 'User ID:'],
		-pwdlabel => ['PASSIVE', undef, undef, 'Password:'],
		);
  $ok -> focus;
  return $w;
}

sub Accept {
  my $w = shift;
  $w -> {Configure}{-accept} = '1';
}

sub Show {
  my( $w, @args) = @_;
  $w -> waitVariable( \$w -> {'Configure'}{'-accept'} );
  $w -> withdraw;
  return 'Login';
}


1;
