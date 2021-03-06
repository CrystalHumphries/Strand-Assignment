#!/usr/bin/perl 
use strict;
use warnings;
use diagnostics;

####information regarding the sam flags assignment is at the bottom####

my ($QNAME,$FLAG,$RNAME,$POS,$MAPQ,$CIGAR,$RNEXT,$PNEXT,$TLEN,$SEQ,$rest,$seq_length,$start,$stop,$internal_flag, $line);
my ( %seq_pair, %spliced );

#&print_sam_file_header;
while ($line = <>)
{
    chomp ($line);
    ($QNAME,$FLAG,$RNAME,$POS,$MAPQ,$CIGAR,$RNEXT,$PNEXT,$TLEN,$SEQ,$rest)= split(/\t/,$line,11);
    if ( $QNAME eq '@SQ' )
    {
	print_line($line);
    }
    else{
	if ( $CIGAR =~m/\d{1,2}N/){  # GSNAP already places strand flag on splice junctions
	    print_line ($line);
	}
	elsif ( ( $FLAG=~m/^(165|133|181|101|117|69|77|141)/) ) { # FLAGs for unmapped reads
	    print_line($line); 
	}
	elsif (  ( $FLAG=~m/^(73|89|121|153|185|137)/) ) {# only assign strand to the one mapped read
	    if (($rest =~m /XS\:A\:(\+|-)/) ) {  #print if already stand is already assigned
		print_line($line); 
	    }
	    else{
		print_negative_strand($line) if ( ( $FLAG=~m/^(121|153|185)/ ) ) ; 
		print_positive_strand($line) if ( ( $FLAG=~m/^(73|89|137)/ ) );
	    }
	}
	elsif (  ( $FLAG=~m/^(99|147|83|163|67|131|115|179|81|161|97|145|65|129|113|177)/) ) {# assign strand to both reads
	    if ( ($rest =~m /XS\:A\:(\+|-)/) ) {  #print if already stand is already assigned
		print_line($line);
	    }
	    else{
		print_positive_strand($line) if ( ( $FLAG=~m/^(99|163|67|131|161|97|65|129)/ ) );
		print_negative_strand($line) if ( ( $FLAG=~m/^(147|83|115|179|81|113|177)/ ) );
	     }
	}else{
	    print_line($line);
	}
    }
}


sub print_positive_strand                # adds an XS:A:+ to the strand that mapped to the positive strand
{
    my ($old_line)=shift;
    my $new_line = join("\t", $old_line, "XS:A:+");
    print_line($new_line);
}

sub print_negative_strand              # adds an XS:A:- to the strand that mapped to the positive strand
{
    my ($old_line)=shift;
    my $new_line = join("\t", $old_line, "XS:A:-");
    print_line($new_line);
}

sub print_line{
    my $line  = shift;
    print $line."\n";
}


sub print_sam_file_header
{
    print "\@SQ\tSN:chr1\tLN:247249719\n";
    print "\@SQ\tSN:chr2\tLN:242951149\n";
    print "\@SQ\tSN:chr3\tLN:199501827\n";
    print "\@SQ\tSN:chr4\tLN:191273063\n";
    print "\@SQ\tSN:chr5\tLN:180857866\n";
    print "\@SQ\tSN:chr6\tLN:170899992\n";
    print "\@SQ\tSN:chr7\tLN:158821424\n";
    print "\@SQ\tSN:chr8\tLN:146274826\n";
    print "\@SQ\tSN:chr9\tLN:140273252\n";
    print "\@SQ\tSN:chr10\tLN:135374737\n";
    print "\@SQ\tSN:chr11\tLN:134452384\n";
    print "\@SQ\tSN:chr12\tLN:132349534\n";
    print "\@SQ\tSN:chr13\tLN:114142980\n";
    print "\@SQ\tSN:chr14\tLN:106368585\n";
    print "\@SQ\tSN:chr15\tLN:100338915\n";
    print "\@SQ\tSN:chr16\tLN:88827254\n";
    print "\@SQ\tSN:chr17\tLN:78774742\n";
    print "\@SQ\tSN:chr18\tLN:76117153\n";
    print "\@SQ\tSN:chr19\tLN:63811651\n";
    print "\@SQ\tSN:chr20\tLN:62435964\n";
    print "\@SQ\tSN:chr21\tLN:46944323\n";
    print "\@SQ\tSN:chr22\tLN:49691432\n";
    print "\@SQ\tSN:chrX\tLN:154913754\n";
    print "\@SQ\tSN:chrY\tLN:57772954\n";
}


##################################################################################################
# SAM FLAG explanation:                                                                          #
# please see accompanying documentation                                                          #
##################################################################################################


	
	



