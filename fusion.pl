#!/usr/bin/env perl 
 
# This script considers whether two neighboring clusters 
# should be merged into one
# Parameters:
#  1 - nb of nueclotides for merging the clusters
#    (if clusters C1 and C2 are less than PARAM1 nucleotides apart)
#      they are merged
#  2 - Name of the file containing the clusters
#   Format of the cluster file should be (tab separated):
#	#chr start end #tags #strand
#
#  WARNING: this script assumes that clusters are sorted 
#      first by #chr, then by #strand, then by starting position
#
##############################
#use strict; 

if ($#ARGV != 1) {
	die "\n\tUsage: $0 #nucl clusterFileName\n\n";
}
my $ecart = $ARGV[0]; # nb de nucleotides d'écart pour fusionner 2 clusters
open C, "<$ARGV[1]" or die "Impossible ouvrir le fichier de cluster";

my $i = 0; 
my $courante = <C>; 

while (my $ligne2 = <C>) {

	my @cols1 = split /\s+/, $courante;
	my @cols2 = split /\s+/, $ligne2;

	if ((($cols1[2] + $ecart) >= $cols2[1]) and ($cols1[0] eq $cols2[0]) and ($cols1[4] eq $cols2[4])) {
		$i++; 

		#print join("\t",@cols1),"\n";
		#print join("\t",@cols2),"\n";
		$courante = join ("\t", $cols1[0], $cols1[1], $cols2[2], $cols1[3]+$cols2[3], $cols1[4]);

		#print ("$courante\n\n");
	} 
	else { 
		print("$courante"); 
		$courante = $ligne2;
	}
	
}

print ("$courante");

 # print "nb fusion = $i\n";

close C; 
