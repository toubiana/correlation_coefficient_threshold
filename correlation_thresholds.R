#/
## CORRELATION THRESHOLDS
## AUTHOR: David Toubiana
## email: dtoubiana@pucp.edu.pe
## SHORT DESCRIPTION: Constructing correlation networks iteratively at different r-values and p-values 
## 
#/

#/
## ----------------------------------------------DISCLAIMER----------------------------------------------------##
## This SOFTWARE PRODUCT is provided by THE PROVIDER "as is" and "with all faults."
## THE PROVIDER makes no representations or warranties of any kind concerning the safety,
## suitability, lack of viruses, inaccuracies, typographical errors, or other harmful
## components of this SOFTWARE PRODUCT. There are inherent dangers in the use of any software,
## and you are solely responsible for determining whether this SOFTWARE PRODUCT is compatible
## with your equipment and other software installed on your equipment.
## You are also solely responsible for the protection of your equipment and backup of your data,
## and THE PROVIDER will not be liable for any damages you may suffer in connection with using,
## modifying, or distributing this SOFTWARE PRODUCT.
## ---------------------------------------------DISCLAIMER END--------------------------------------------------##
#/

#/
##----------------------------------------------DESCRIPTION-----------------------------------------------------##
##   function that takes in a normalized dataset param =data and the minimum and maximum r values
##   constructs a correlation matrix and corresponding p-value matrix.
##   networks are constructed from varying thresholds and then subjected to network generation
##   the networks are being analyzed for network measures
##   the return value contains a dataframe that contains the different constellation of r
##   and p-values with corresponding network measures
##   parameter method holds which correlation to run: pearson, spearman etc..
##  For a full description of the GA, we refer the user to the accompanying publication.
##----------------------------------------------DESCRIPTION END-------------------------------------------------##
#/ 

#/
## ------------------------------------------------PARAMETERS---------------------------------------------------##
## data: a dataset containing metabolite profiles
## min.r: the absolute minimum correlation coefficient to be calculated (0)
## max.r: the absolute maximum correlation coefficient to be calculated (0)
## cor.method: the method to compute the correlation coefficient, by default Pearson
## ----------------------------------------------PARAMETERS END--------------------------------------------------##
#/

# License
# 
# The following license governs the use of the source code for CORRELATION_THRESHOLD in academic and educational environments. 
# Commercial use requires a commercial license from the author directly: 
#     David Toubiana
# email: dtoubiana@pucp.edu.pe or david.toubiana@gmail.com
# 
# ACADEMIC PUBLIC LICENSE
# 
# Original license written by Andras Varga and modified by David Toubiana (license text is in public domain)
# 
# Preamble
# 
# This license contains the terms and conditions of using the source code for GENETIC_ALGORIHM in noncommercial settings: at academic
# institutions for teaching and research use, and at non-profit research organizations. You will find that this license provides 
# noncommercial users of the source code for the GENETIC_ALGORIHM with rights that are similar to the well-known GNU General Public License, 
# yet it retains the possibility for the source code for the GENETIC_ALGORIHM authors to financially support the development by selling 
#commercial licenses. In fact, if you intend to use the source code for the GENETIC_ALGORIHM in a “for-profit” environment, where research
# is conducted to develop or enhance a product, is used in a commercial service offering, or when a commercial company uses the source 
# code for the GENETIC_ALGORIHM to participate in a research project (for example government-funded or EU-funded research projects), 
# then you need to obtain a commercial license for the source code for the GENETIC_ALGORIHM. In that case, please contact the Author to
# inquire about commercial licenses.
# 
# What are the rights given to noncommercial users? Similarly to GPL, you have the right to use the software, to distribute copies, to 
# receive source code, to change the software and distribute your modifications or the modified software. Also similarly to the GPL, 
# if you distribute verbatim or modified copies of this software, they must be distributed under this license.
# 
# By modeling the GPL, this license guarantees that you’re safe when using the source code for the GENETIC_ALGORIHM in your work, for 
# teaching or research. This license guarantees that the source code for the GENETIC_ALGORIHM will remain available free of charge for 
# nonprofit use. You can modify the source code for the GENETIC_ALGORIHM to your purposes, and you can also share your modifications. 
# Even in the unlikely case of the authors abandoning the source code for the GENETIC_ALGORIHM entirely, this license permits anyone to 
# continue developing it from the last release, and to create further releases under this license.
# 
# We believe that the combination of noncommercial open-source and commercial licensing will be beneficial for the whole user community, 
# because income from commercial licenses will enable faster development and a higher level of software quality, while further enjoying 
# the informal, open communication and collaboration channels of open source development.
# 
# The precise terms and conditions for using, copying, distribution and modification follow.
# 
# TERMS AND CONDITIONS FOR USE, COPYING, DISTRIBUTION AND MODIFICATION
# Definitions
# 
# “Program” means a copy of the source code for the GENETIC_ALGORIHM, which is said to be distributed under this Academic Public License.
# 
# “Work based on the Program” means either the Program or any derivative work under copyright law: that is to say, a work containing the 
# Program or a portion of it, either verbatim or with modifications and/or translated into another language. (Hereinafter, translation is 
# included without limitation in the term “modification”.)
# 
# “Using the Program” means any act of creating executables that contain or directly use libraries that are part of the Program, running 
# any of the tools that are part of the Program, or creating works based on the Program.
# 
# Each licensee is addressed as “you”.
# 
# §1. Permission is hereby granted to use the Program free of charge for any noncommercial purpose, including teaching and research at 
# universities, colleges and other educational institutions, research at non-profit research institutions, and personal non-profit 
# purposes. For using the Program for commercial purposes, including but not restricted to consulting activities, design of commercial
# hardware or software networking products, and a commercial entity participating in research projects, you have to contact the Author 
# for an appropriate license. Permission is also granted to use the Program for a reasonably limited period of time for the purpose of
# evaluating its usefulness for a particular purpose.
# 
# §2. You may copy and distribute verbatim copies of the Program’s source code as you receive it, in any medium, provided that you 
# conspicuously and appropriately publish on each copy an appropriate copyright notice and disclaimer of warranty; keep intact all the
# notices that refer to this License and to the absence of any warranty; and give any other recipients of the Program a copy of this 
# License along with the Program.
# 
# §3. You may modify your copy or copies of the Program or any portion of it, thus forming a work based on the Program, and copy and 
# distribute such modifications or work under the terms of Section 2 above, provided that you also meet all of these conditions:
#     
# a) You must cause the modified files to carry prominent notices stating that you changed the files and the date of any change.
# 
# b) You must cause any work that you distribute or publish, that in whole or in part contains or is derived from the Program or any part 
#    thereof, to be licensed as a whole at no charge to all third parties under the terms of this License.
# 
# These requirements apply to the modified work as a whole. If identifiable sections of that work are not derived from the Program, and
# can be reasonably considered independent and separate works in themselves, then this License, and its terms, do not apply to those 
# sections when you distribute them as separate works. But when you distribute the same sections as part of a whole which is a work based 
# on the Program, the distribution of the whole must be on the terms of this License, whose regulations for other licensees extend to the 
# entire whole, and thus to each and every part regardless of who wrote it. (If the same, independent sections are distributed as part of 
# a package that is otherwise reliant on, or is based on the Program, then the distribution of the whole package, including but not 
# restricted to the independent section, must be on the unmodified terms of this License, regadless of who the author of the included 
# sections was.)
# 
# Thus, it is not the intent of this section to claim rights or contest your rights to work written entirely by you; rather, the intent
# is to exercise the right to control the distribution of derivative or collective works based or reliant on the Program.
# 
# In addition, mere aggregation of another work not based on the Program with the Program (or with a work based on the Program) on a 
# volume of storage or distribution medium does not bring the other work under the scope of this License.
# 
# §4. You may copy and distribute the Program (or a work based on it, under Section 3) in object code or executable form under the terms
#     of Sections 2 and 3 above provided that you also do one of the following:
#     
# a) Accompany it with the complete corresponding machine-readable source code, which must be distributed under the terms of Sections 2
#    and 3 above on a medium customarily used for software interchange; or,
# 
# b) Accompany it with a written offer, valid for at least three years, to give any third party, for a charge no more than your cost of
#    physically performing source distribution, a complete machine-readable copy of the corresponding source code, to be distributed 
#    under the terms of Sections 2 and 3 above on a medium customarily used for software interchange; or,
# 
# c) Accompany it with the information you received as to the offer to distribute corresponding source code. (This alternative is allowed 
#    only for noncommercial distribution and only if you received the program in object code or executable form with such an offer, in
#    accord with Subsection b) above.)
# 
# The source code for a work means the preferred form of the work for making modifications to it. For an executable work, complete source
# code means all the source code for all modules it contains, plus any associated interface definition files, plus the scripts used to
# control compilation and installation of the executable. However, as a special exception, the source code distributed need not include 
# anything that is normally distributed (in either source or binary form) with the major components (compiler, kernel, and so on) of the
# operating system on which the executable runs, unless that component itself accompanies the executable.
# 
# If distribution of executable or object code is made by offering access to copy from a designated place, then offering equivalent access
# to copy the source code from the same place counts as distribution of the source code, even though third parties are not compelled to 
# copy the source along with the object code.
# 
# §5. You may not copy, modify, sublicense, or distribute the Program except as expressly provided under this License. Any attempt 
# otherwise to copy, modify, sublicense or distribute the Program is void, and will automatically terminate your rights under this License. 
# However, parties who have received copies, or rights, from you under this License will not have their licenses terminated so long as 
# such parties remain in full compliance.
# 
# §6. You are not required to accept this License, since you have not signed it. Nothing else grants you permission to modify or 
# distribute the Program or its derivative works; law prohibits these actions if you do not accept this License. Therefore, by modifying
# or distributing the Program (or any work based on the Program), you indicate your acceptance of this License and all its terms and 
# conditions for copying, distributing or modifying the Program or works based on it, to do so.
# 
# §7. Each time you redistribute the Program (or any work based on the Program), the recipient automatically receives a license from the
# original licensor to copy, distribute or modify the Program subject to these terms and conditions. You may not impose any further 
# restrictions on the recipients’ exercise of the rights granted herein. You are not responsible for enforcing compliance by third parties
# to this License.
# 
# §8. If, as a consequence of a court judgment or allegation of patent infringement or for any other reason (not limited to patent 
# issues), conditions are imposed on you (whether by court order, agreement or otherwise) that contradict the conditions of this License,
# they do not excuse you from the conditions of this License. If you cannot distribute so as to satisfy simultaneously your obligations 
# under this License and any other pertinent obligations, then as a consequence you may not distribute the Program at all. For example, 
# if a patent license would not permit royalty-free redistribution of the Program by all those who receive copies directly or indirectly 
# through you, then the only way you could satisfy both it and this License would be to refrain entirely from distribution of the Program.
# 
# If any portion of this section is held invalid or unenforceable under any particular circumstance, the balance of the section is 
# intended to apply and the section as a whole is intended to apply in other circumstances.
# 
# §9. If the distribution and/or use of the Program are restricted in certain countries either by patents or by copyrighted interfaces,
# the original copyright holder who places the Program under this License may add an explicit geographical distribution limitation 
# excluding those countries, so that distribution is permitted only in or among countries not thus excluded. In such case, this License
# incorporates the limitation as if written in the body of this License.
# 
# NO WARRANTY
# 
# §10. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. 
# EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY 
# KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
# PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME 
# THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
# 
# §11. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED ON IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY 
# AND/OR REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR 
# CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
# RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN 
# IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
# 
# END OF TERMS AND CONDITIONS
# 
# In case the above text differs from the license file in the source distribution, the latter is the valid one.

## -------------------------------------------------LICENSE END-------------------------------------------------------------------------##

## --------------------------------------------------FUNCTIONS--------------------------------------------------------------------------##
correlation.thresholds <- function(data, 
                                   min.r = 0, max.r = 1, rvalue.intervals= 11,
                                   p.min = 0.01, p.max = 0.05, pvalue.intervals = 5 ,
                                   cor.method = 'pearson'){
#   function that takes in a normalized dataset param =data and the minimum and maximum r values
#   constructs a correlation matrix and corresponding p-value matrix.
#   networks are constructed from varying thresholds and then subjected to network generation
#   the networks are being analyzed for network measures
#   the return value contains a dataframe that contains the different constellation of r
#   and p-values with corresponding network measures
#   parameter method holds which correlation to run: pearson, spearman etc.
  
  # first create correlation matrix and corresponding p-value matrix by calling function correlation.network
  print("function: correlation thresholds")
  cor.network <- correlation.network(data,cor.method = cor.method)
  cor <- cor.network@cor.matrix  # by default pearson correlation
  # for the next call, the test_cor function must be preloaded
  p.cor <- cor.network@p.value.mat
  
  p.seq <- seq(p.min,p.max,length.out=pvalue.intervals)
  r.seq <- seq(min.r,max.r,length.out=rvalue.intervals)
  
  # prepare a matrix that contains return values
  network.measures <- matrix(nrow=length(r.seq)*length(p.seq),ncol=8)  # this is hard coded
  colnames(network.measures) <- c("r-value","p-value","nnode","nedges",
                                  "degree","density","clust.coef","diameter")
  
  
  # now run nested for loops to go over thresholds r
  count  <- 1 # count variable for the row index of network measure table
  for (r in r.seq){
    for(p in p.seq){ 
     print(paste0('r: ',r,' p: ',p))
      # create r coefficient network for specific r and p values
      # call function correlation.network.thresh
      sig.cor <- correlation.network.thresh(cor,p.cor,r,p)
    
      # now that we have the matrix only with "significant" correlations
      # we can construct the correlation networks
      # replace all the significant correlations with value 1
      sig.cor.ones <- sig.cor
      x <- which(sig.cor!=0)
      sig.cor.ones[x] <- 1
      # construct network using igraph method -> load library igraph
      library(igraph)
      
      # convert to igraph network
      for(m in 1:nrow(sig.cor.ones)){sig.cor.ones[m,m] <- 0}
      gr1 <- graph.adjacency(sig.cor.ones,mode="lower", diag=F)
      
      # calculate network parameters
      num.nodes <- vcount(gr1)
      num.edges <- ecount(gr1)
      degree <- mean(degree(gr1))
      density <- graph.density(simplify(gr1),loops=F)
      clus.coef <- transitivity(gr1,type="global")
      diameter <- diameter(gr1,unconnected=T)
      
      #fill values into return table: network.measures
      network.measures[count,] <- c(r,p,num.nodes,num.edges,degree,
                                       density,clus.coef,diameter)
      # increment count
      count  <- count + 1
      rm(sig.cor); rm(sig.cor.ones);rm(gr1)
      gc()
    }# end nested loop
  } # end loop
  
  # prepare return variable - S4 class
  setClass("network.properties",representation(prop="matrix",
                                              cor.matrix="matrix",p.value.mat="matrix"))
  # prepare return object 
  ret.object  <- new("network.properties",prop=network.measures,cor.matrix=cor,p.value.mat=p.cor)
  # return
  return(ret.object)
} # end function

#==========================================================================================================
correlation.network <- function(data,cor.method='pearson'){
  # create correlation matrix and corresponding p-value matrix
  # parameter method holds type of correlation to be run
  print("function: correlation network")
  cor <- cor(data,method=cor.method, use = 'complete.obs')  # by default pearson correlation
  # for the next make call to function test.cor
  p.cor <- test.cor(data,cor.method=cor.method)
  #p.cor.alt <- corr.test(data,method=cor.method,use='pairwise',adjust = 'none')
  # define return variable - S4 class
  setClass("cor.network",representation(cor.matrix="matrix",p.value.mat="matrix"))
  # prepare return object 
  ret.object  <- new("cor.network",cor.matrix=cor,p.value.mat=p.cor)
  return(ret.object)
} # end function

#==========================================================================================================
correlation.network.thresh <- function(cor,p.cor,r,p){
  # same as function correlation.network, but returns an r coefficient matrix for specific 
  # r coefficient and p-value thresholds
  # vector containing indeces for specific r threshold
    print("function: correlation network thresh")
  # return variable holding matrix for specific r and p values
  sig.cor <- cor
  sig.cor[,] <- 0
  
  #  x.cor <- which(abs(cor)>=r,arr.ind=T)
  x.cor <- which(abs(cor)>=r)
  p.cor.ind <- which(p.cor[x.cor]<=p)
  if(length(p.cor.ind)>0){
    sig.cor[x.cor[p.cor.ind]] <- cor[x.cor[p.cor.ind]]
  }
  
  return(sig.cor)
} # end function

#==========================================================================================================
test.cor <- function(data, cor.method='pearson'){
  # calculating the p-values related to the correlation
  # remember that you have to edit the files in excel first - delete first column(numbers)
  # by default the method uses pearson correlation, change the code inside the function
    print("function: test cor")
  mat <- matrix(nrow=ncol(data),ncol=ncol(data),dimnames=list(colnames(data),colnames(data)))
  
  for(j in 1:ncol(data)){
      #print(Sys.time())
      #print(j)
    for(k in 1:ncol(data)){
      #print(paste(j,' : ',k,sep = ""))
      c <- cor.test(data[,j],data[,k],method=cor.method,use="pairwise.complete.obs")
      #c <- cor.test(data[,j],data[,k],method="spearman")
      mat[j,k] <- c$p.value
      mat[k,j] <- c$p.value
    } # end nested nested for loop
      #print(Sys.time())
  }# end nested for loop
  # return variable
  return(mat)
} # end function
#==========================================================================================================
