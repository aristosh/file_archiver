#!/usr/bin/perl

use warnings;
use strict;

use DateTime;
use Getopt::Long;

my @files = @ARGV;
my $currentDir = `pwd`;
$currentDir =~ s/\n$//g;
my $archiveDir = "$currentDir/.archives";
my $now = DateTime->now;
my $date = $now->ymd;
my $time = $now->hms;
my $datetime = "$date$time";

if(!@files) {
  print "Usage 1 : archiver [file1] [file2] ... [fileN]\n";  
  print "Usage 2 : archiver [--purge | --list]\n";
  exit 3;
}

my $list = 0;
my $purge = 0;
GetOptions(
  'list' => \$list,
  'purge' => \$purge,
) or die "Invalid options passed to $0\n";

if($list) {
  system "ls", $archiveDir;
  exit 0;
}

if($purge) {
  system "rm", "-rf", $archiveDir, "/*";
  exit 0;
}

$datetime =~ s/[^0-9]//g;
system "mkdir", "-p", $archiveDir;

foreach(@files) {
  my $file =  $_;

  my $archivedFile = "$archiveDir/[$datetime][$file]";
  if(!system("mv", "-f", $file, $archivedFile)) {
    print "File $file has been archived to $archivedFile\n";
  }
}
