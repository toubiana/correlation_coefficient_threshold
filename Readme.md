
 CORRELATION THRESHOLDS
 AUTHOR: David Toubiana
 email: dtoubiana@pucp.edu.pe
 SHORT DESCRIPTION: Constructing correlation networks iteratively at different r-values and p-values 
 



 ----------------------------------------------DISCLAIMER----------------------------------------------------
 This SOFTWARE PRODUCT is provided by THE PROVIDER "as is" and "with all faults."
 THE PROVIDER makes no representations or warranties of any kind concerning the safety,
 suitability, lack of viruses, inaccuracies, typographical errors, or other harmful
 components of this SOFTWARE PRODUCT. There are inherent dangers in the use of any software,
 and you are solely responsible for determining whether this SOFTWARE PRODUCT is compatible
 with your equipment and other software installed on your equipment.
 You are also solely responsible for the protection of your equipment and backup of your data,
 and THE PROVIDER will not be liable for any damages you may suffer in connection with using,
 modifying, or distributing this SOFTWARE PRODUCT.
 ---------------------------------------------DISCLAIMER END--------------------------------------------------



----------------------------------------------DESCRIPTION-----------------------------------------------------
   function that takes in a normalized dataset param =data and the minimum and maximum r values
   constructs a correlation matrix and corresponding p-value matrix.
   networks are constructed from varying thresholds and then subjected to network generation
   the networks are being analyzed for network measures
   the return value contains a dataframe that contains the different constellation of r
   and p-values with corresponding network measures
   parameter method holds which correlation to run: pearson, spearman etc..
  For a full description of the GA, we refer the user to the accompanying publication.
----------------------------------------------DESCRIPTION END-------------------------------------------------
 


 ------------------------------------------------PARAMETERS---------------------------------------------------
 data: a dataset containing metabolite profiles
 min.r: the absolute minimum correlation coefficient to be calculated (0)
 max.r: the absolute maximum correlation coefficient to be calculated (0)
 cor.method: the method to compute the correlation coefficient, by default Pearson
 ----------------------------------------------PARAMETERS END--------------------------------------------------
