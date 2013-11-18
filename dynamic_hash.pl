#!/usr/bin/perl
use Data::Dumper;
$data = <<'DATA';
jibber|'husband'->'fred','wife'->'barney'
flintstones|'husband'->'george','wife'->'jane','sons'->'david,petar'
simpsons|'husband'->'homer','wife'->'marge','sons'->'adam'
rey|'husband'->'tom,john','wife'->'dia,diana','sons'->'bart','daughter'->'serra,sianna'
DATA

my @data = split('\n',$data); # split data by new line to get each line into array
my $r = {};                   # create an empty hash reference, [] is used for empty array reference             
foreach (@data) {             # iterate through each line
	chomp;                                        # chomp new line 
	my($family,$members) = split('\|',$_);        # split line by '|' to separate family name from members  
	my @mem = split('\',\'',$members);            # split line by "','" separate each members into array .. we used ',' as a spit delimeter so we don't split sons which are also separated by comma.
	foreach (@mem) {                              
		s/'//g;
		my($member,$name) = split('->',$_);       # split line by '->' to get member name and value associated with it
		$r{$member} = {};                         # create an empty (anonymous) hash for each family  
		if($name =~ m/,/){                        # if values are comma separated then split them using command and put them into anonymous array and assing that to member
			my @names = split(',',$name);         
			$r->{$family}{$member} = [@names];
		}else{
			$r->{$family}{$member} = $name;       # if not comma separated then directly assing values to member.
		}
	}
}

print Dumper($r); # dumper takes only reference so if you have hash then you can pass "\%r" 
