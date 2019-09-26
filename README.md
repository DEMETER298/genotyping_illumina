# VCF2ABH: converter from VCF to ABH format (for illumina platform)

Usage:

% perl VCF2ABH.pl -in INPUT_VCF -out OUTPUT_FILE -A Accession_NAMEfor"A" -B Accession_NAMEfor"B" 


## Example

1. Download VCF2VCF.pl and test.vcf file from this site.

2. To obtain the ABH genotype format based on parental genotypes. Run the script of VCF2ABH. Parental genotypes are Nankanzarai=A and PGC157=B.

```
perl VCF2ABH.pl -in test.vcf -out test_ABH.csv -A Nankanzairai -B PGC157
```

3. The obtained csv file can be used as an R/qtl input file (as 'csvr' format) after removing the parents' column.


## Citing VCF2ABH
Cite this article as:  IonBreeders: semi-automated bioinformatics plugins toward genomics-assisted breeding. 

Ogiso-Tanaka E, Yabe S and Tanaka T

Breeding Science (in submitted)
