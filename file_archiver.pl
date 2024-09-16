#!/usr/bin/perl

use warnings;
use strict;

use DateTime;
use Getopt::Long;

GetOptions(
  'file=s{,}' => \my @files,
) or die "Invalid options passed to $0\n";


my $archiveDir = ".archives";
my $now = DateTime->now;
my $date = $now->ymd;
my $time = $now->hms;
my $datetime = "$date$time";
$datetime =~ s/[^0-9]//g;
system("mkdir", "-p", $archiveDir);

foreach(@files) {
  my $file =  $_;

  my $archivedFile = "$archiveDir/[$datetime][$file]";
  system("mv", "-f", $file, $archivedFile) or die "File not found";

  print "File $file has been archived to $archivedFile\n";
}
