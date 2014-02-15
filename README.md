The purpose of this program is to assign the strand ID that is used by cufflinks "XS:A: (+ or - or ?)" to GSNAP version older than 2012-04-27. 

How to run:

    cat file.sam | perl AssignStrand.pl  
      
How to Run (from BAM file and converting back to BAM):
  
    samtools view aln.bam | perl AssignStrand.pl | samtools view -Sb - -o new.bam
    
Purpose: 
  to strand information to aligned reads to be interepreted by cufflinks
  
How:
  based off the SAM FLAG ids, as seen here <http://ppotato.files.wordpress.com/2010/08/sam_output2.png>


   
