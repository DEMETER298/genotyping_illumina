#!/usr/bin/perl

# usage ＄perl VCF2ABH.pl -in INPUT_VCF -out OUTPUT_FILE -A Accession_NAMEfor"A" -B Accession_NAMEfor"B" 

#use strict;
#use warnings;
use utf8;
use open ":utf8";
use Getopt::Long;

my $VCF=0;
my $ABH=0;
my $AccA=0;
my $AccB=0;
my @dat = "";
my $dat = 0;
my $a = 0;
my $SKIP = 0;
my $A = 0;
my $B = 0;
my $AA = 0;
my $BB = 0;
my $CHR = 0;
my $POS = 0;
my $REF = 0;
my $SNP = 0;
my @OUT = "";


GetOptions('in=s' => \$VCF, 'out=s' => \$ABH, 'A=s' => \$AccA, 'B=s' => \$AccB);

print "INPUT = $VCF\nOUTPUT = $ABH\nAccession_A = $AccA\nAccession_B= $AccB\n";


open(VCFFILE, "< $VCF") or die("error :$!");
open(OUT,">$ABH");

print OUT "CHR\tPOSITION\t$AccA\t$AccB";

while(<VCFFILE>){
	chomp;
	$a = 0;
	@dat = split("\t",$_);
	if(/\#CHROM/){
		foreach $dat(@dat){
			$a ++;
			if($a > 9){
				if($dat =~ m/^$AccA/){
					$A = $a;
				}elsif($dat =~ m/^$AccB/){
					$B = $a;
				}else{
					print OUT "\t$dat";
				}
			}
		}
		print "A: $AccA\t$A\nB: $AccB\t$B\n";
		print OUT "\n";
	}elsif(/\#/){
	}else{
		undef(@OUT);
		$CHR = $dat[0];
		$POS = $dat[1];
		$REF = $dat[3];
		$SNP = $dat[4];
		$SKIP = 0;
		$AA = $A - 1;
		$BB = $B - 1;
		if($dat[$AA] =~ /0\/0/){
			if($dat[$BB] =~ m/1\/1/){
				$OUT[0] = "A";
				$OUT[1] = "B";
			}else{
				$SKIP = 1;
			}
		}elsif($dat[$AA] =~ m/1\/1/){
			if($dat[$BB] =~ m/0\/0/){
				$OUT[0] = "B";
				$OUT[1] = "A";
			}else{
				$SKIP = 1;
			}
		}else{
			$SKIP = 1;
		}
		if($SKIP != 1){
			print OUT "$CHR\t$POS\tA\tB";
			foreach $dat(@dat){
				$a ++;
				if($a > 9){
					if($a == $A or $a == $B){
					}else{
						if($dat[$a] =~ m/0\/0/){
							print OUT "\t$OUT[0]";
						}elsif($dat[$a] =~ m/1\/1/){
							print OUT "\t$OUT[1]";
						}elsif($dat[$a] =~ m/0\/1/){
							print OUT "\tH";
						}else{
							print OUT "\t\.";
						}
					}
				}
			}
			print OUT "\n";
		}
	}
}
