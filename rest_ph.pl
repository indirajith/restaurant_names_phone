#!/usr/bin/perl 

#use warnings;

#Library for www in Perl module
use LWP::Simple;

$url = 'http://www.justdial.com/Bangalore/restaurants';
#get the url contents
$url_content = get $url || die "Error getting contents from specified $url $!, $?";

open $file, '>>', "output.txt" or die "Cannot open output.txt: $!";

#split the contents by new line charector
foreach $url_c_l (split("\n", $url_content))
	{
#	if($url_c_l =~ m/<a href="(.+)" title="(.+)">\D+[^<>]<\/a>/)
#	if($url_c_l =~ m/<span class="webkit-html-text-node">(.+)<\/span>/)
#patern match for hotel titles
	if($url_c_l =~ m/title='(.+)'\s>([^View Map].+)<\/a>/)
		{
		$hotel_name = "${1}\n";
		print "\n$hotel_name\n";
#write the hotel name into file
		print $file "$hotel_name\n"
		}
#patern match for hotel phone numbers
	elsif($url_c_l =~ m/<p class="jrcw"><span class="jrc"><\/span><a href="tel:(.{13})"><b>.+<\/p>/)
		{
		$hotel_phno = ${1};
		print "$hotel_phno\n";
#write the hotel phone number into file
		print $file "$hotel_phno\n"
		}
	}
close $file;
