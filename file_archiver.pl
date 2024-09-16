#!/usr/bin/perl

use warnings;
use strict;

use DateTime;

my $archiveDir = ".archives";
my $now = DateTime->now;
my $date = $now->ymd;
my $time = $now->hms;
my $datetime = "$date$time";
$datetime =~ s/[^0-9]//g;
system("mkdir", "-p", $archiveDir);

foreach(@ARGV) {
  my $file =  $_;

  my $archivedFile = "$archiveDir/[$datetime][$file]";
  system("mv", "-f", $file, $archivedFile);

  print "File $file has been archived to $archivedFile\n";
}
