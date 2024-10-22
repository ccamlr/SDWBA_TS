--------------------------------------------------
SDWBApackage2010, version 1.1 June 2012
krill target strength calculation based on
Stochastic Distorted-Wave Born Approximation model
parameterized by body digitalization 

GNU Public Licence Copyright (c) Lucio Calise
Comments and suggestions to lucio@imr.no


Lucio Calise
Observation Methodology,
Institute of Marine Research
P.O. Box 1870 Nordnes
NO-5817 Bergen, Norway
--------------------------------------------------


The Matlab programs provided with this package allow one to calculate the Target Strength (TS)
of a krill based on the full and simplified SDWBA model with parameterization derived from a 
digitalized body shape as described in various Demer and Conti works.

The programs were implemented and tested using Matlab Version 7.12.0.635 (R2011a), 
64-bit (win64) running under Windows.

The package does not include any theoretical changes from the SDWBA model endorsed by CCAMLR 
as the 'Antarctic krill TS model' (SC-CAMLR, 2005). 
It is an improvement and a more correct version of the previous Matlab package SDWBApackage20050603 
implemented by Stephane Conti on 03 June 2005 (which is also included in the "Background" directory as zipped folder). 
In general, the package follows the implementation, the variable names and the format 
of that previous package. 
The rational of the package and the processing differences between the two packages are described in:

Calise L. and Skaret G. 2011.
SENSITIVITY INVESTIGATION OF THE SDWBA ANTARCTIC KRILL 
TARGET STRENGTH MODEL TO FATNESS, MATERIAL CONTRAST AND ORIENTATION. 
CCMLAR Science, Volume 18, pages 97-122. (in press)

the .pdf of the paper is included in the "Background" directory.


The foremost aim of the package is to provide to the CCMLAR users a friendly interface tool to predict
the TS of an Euphasia superba population with known mean length and orientation.

By using the polynomial representation of TS function (simplified SDWBA) over the given distribution 
of orientation a fast estimation of TS for a set of frequencies and krill lengths can be obtained.




Description
Running the program Process_Krill_SDWBA_TS.m gives three options:

1. Calculate the Target Strength
2. Average the Target Strength over a distribution of orientations
3. Exit the program.


1. Calculate the Target Strength option
A window interface will show up and the different parameters for the model can be changed 
from the default values. These are stored in the script Default_parameters.m included in the "bin" folder.
They can be changed with new values inside the script (do not change the variables names).
By placing the pointer on one item shows a tooltip related to the parameter.

The window interface is the main formal difference between this package and the SDWBApackage20050603. 
It is composed of four panels:

	1) the Storage panel allows one to set the name and the directory where the results are saved;

	2) the 'Key Parameters panel' allows one to set the main model parameters. 
	The model is run under the approximation that the material contrasts (g and h) are constant over the modelled krill body. 
	This means that the fileshape.mat file, which collects the position and radii vectors obtained by 
	the body digitalization and the contrast material properties for each discretized cylinder, 
	does not necessary need to contain g and h values.

	3) the 'Basic Parameters panel' collects all the parameters related to the reference digitalized 
	standard body shape of the krill, whose parameters are included in the fileshape.mat file.
	This has to be referred to a head left view image of the animal with points starting from the telson 
	(the first discretized cylinder has to represent the tail (or part of it).
	If the user needs to run the model with different shape, or different than the default parameters, 
	the button 'browse' will give the opportunity to choose the fileshape.mat and then to edit new values 
	for the parameters. 
	It is important to note that if the Actual length is different from the L0 reference length, 
	the simplified SDWBA model obtained by running the next step Average over a distribution of orientations 
	is referred to the first. This means that the Actual length becomes the reference length L0 for 
	the polynomial expression of the simplified SDWBA (Demer and Conti, 2005; Conti and Demer, 2006). 

	The button 'check the shape' allows one to graphically check the shape and the new resampling 
	(see Calise and Skaret, 2011) for frequencies higher than the reference. When the button is pressed, 
	a new window will pop up. All the digitized shape and empirical parameters are shown in the panel "References". 
	Editing a specific frequency in the panel "Resampling" and pushing the button "plot", the resampled shape 
	will be plotted in the graphic window and the new number of cylinders, standard deviation of the stochastic 
	phase and volume will be calculated and shown. Placing the pointer on one item shows a tooltip related 
	to the parameter.

	When the checking is complete, by pressing the button "Exit" it is possibly to return to the setting 
	SDWBA parameters window interface.

	4) by the 'Operational Parameters panel' it is possible to set the frequency and the acoustic wave angle 
	of incidence on the organism. Both parameters can be set as semi-continuous (range options) or discrete values.
	The discrete options can also be used in the case of semi-continuous ranges with specific operational values. 
	For example, if it is required to run the model from 20 kHz to 350 kHz with steps of 10 kHz, but also 
	including the frequencies 38 and 333 kHz, it can be set as:
	[20:10:30 38 40:10:330 333 340:10:350].
	If multiple runs are required and the parameters are different from the default, it is more convenient 
	to change the Default_parameters.m script; for the previous example the variable discrete_frequency will 
	take the form: 
	discrete_frequency = [20:10:30 38 40:10:330 333 340:10:350];
	
Note that in all the Demer and Conti works the wave incidence angle is denoted by theta. 
In this package the variable name 'phi' is preferred to avoid misunderstanding with the krill angle 
of orientation commonly indicated as theta.

All the default values are reset by pressing the button "Reset", while the button "Cancel" breaks 
the entire process.
The button "OK" starts the calculation. The estimated TS are saved under the specified filename and folder. 
This database file is used for the orientation distribution average.
Note that, depending by the range of frequency, the process can be very time consuming.

The SDWBApackage2010 includes the database SDWBA_TS_fat40.mat and SDWBA_TS_fat20.mat which are the 
results running the software over the ranges of frequency = [5:5:750] kHz, phi = [-90:1:269] degrees 
for the Conti and Demer (2006) parameterization over 100 stochastic realizations with 40 and 20 % 
increasing in fatness respectively.




2. Average over a distribution of orientations
A window interface will appear allowing one to set the database which will be analyzed over a given 
Gaussian distribution of orientation described by settable mean and standard deviation. 
Placing the pointer on one item will show a tooltip related to the parameter.

First, the mean and the standard deviation have to be set and then by pushing the browse button the 
database can be selected. 

The system automatically averages the full model TS over the given distribution of 
orientation and calculate the simplified SDWBA model for that distribution.
Both the full and the simplified function are then plot in the graph showing the mean error over the 
range of frequency where the TS were calculated. 
The Parameters panel on the left side of the plot will show the main parameters used to generate the database.
Setting another value of mean and/or standard deviation and pushing the button 'plot' causes the 
processing to be performed on the same database for the new values and the previous plots are kept 
in the graph, but in a gray colour. The previous plots will disappear by pushing the browse button and
choosing a database.

The left lower panel allows one to estimate the TS by using the simplified SDWBA over the given orientation 
distribution for the edited frequency and krill length.

By pushing the button 'Save' a file is saved with the specified database filename, plus the Gaussian 
characteristics (mean and standard deviation) of the distribution used. The file will contain all the useful 
information for the SDWBA full and simplified models, included the 10 coefficients of the 
simplified SDWBA polynomial representation which will also appear in the Matlab command window.
In particular, the variable named "TS" contains the full model backscattering TS for an individual with 
length equal to that of the digitazed one. The variable "TSestim" contains the simplified model backscattering TS 
including these at the interpolation points (the frequencies used by the fitting process and included in the 
variable named "freq_simply"); while the variable "TSestimerror" contains the TS deviations
from the full version of the simplidied results at the knots of the interpolation process (frequencies set
to run the full model).

The saved file can be used to estimate the simplified SDWBA TS over the given orientation distribution 
for a set of frequencies and krill lengths different from the digitalized one. 
In practice, it can be used for fast calculation of mean TS in survey areas where the net sample indicates
a population with mean animal length different from the digitalized one.
First, the file has to be loaded in the Matlab workspace, then the script Simplified_TS_SDWBA.m is run 
with the requested n frequencies and m lengths as input. 
The script will return the n'm matrix 'TS_Simplified' containing the TS values. 
 
The SDWBApackage2010 includes the files SDWBA_TS_fat40_N11_4.mat and SDWBA_TS_fat40_N11_4.mat, 
which are respectively the results of averaging the SDWBA_TS_fat40.mat and SDWBA_TS_fat20.mat databases 
over the distribution of orientation N(11',4').
 
 




Changes from version 1.0 
(please write below if any change from version 1.0 is made)

OCTOBER 2011, Lucio:

	1) New folder called "Background" introduced.
	It contains the SDWBApackage20050603.zip files and the paper Calise and Skaret (2011),
	CCMLAR Science, 18: 97-122. (in press)

	2) Bug on the legend in GUI_Orientation_SDWBA2010_TS.m line 97 was fixed;

	3) Fixed bug when create the name of orientation results 
	(the calculus was correct but not the name of the *.mat results);

	4) Plotting in orientation GUI panel graph window results with stdorientation=0 also; 

		% --- Executes on button press in plot_bottom.
		function A0 = plot_bottom_Callback(hObject, eventdata, handles)
		.
		Line 177 %%% Calculation
			if stdorientation == 0; stdorientation=eps; end

	5) Changed the displaing and saving variables after the orientation process. 
	The coefficients are grouped in the struct variable called �COEFFICIENTS_Simply� 
	including a string for useful insertion in papers.



DECEMBER 2011, Lucio:

        1) Resizing of the figure GUI_Orientation_SDWBA2010_TS and Check_the_digitalized_shape
           is corrected.



MARCH 2012, Lucio (after advice from Marian Pena, IEO, Spain):

	   1) Bug reading the discrete incidence angle in Inputs for SDWBA2010 Antarctic krill Target Strength window.
	      Fixed by replace the correct tag of the values.



APRIL 2012, Lucio (after discussion with Martin Cox, Australian Antarctic Division):

	   1) Introduction of the new variable named "freq_simply" to be saved after the avareging process.
		 The new variable contains the interpolated frequencies used to calculate the Simplified model.
		 With such variable, the user may plot the full and the generate 
		 simplified functions in a new graph both indipendently from the package.

 	   2)	 Lucio after IPY poster conference: Revising Readme_SDWBApackage2010.txt file section: 
		 Averaging over a distribution of orientations with more description of the distribution of orientation .mat file variables.

	   3) Bug correction: post model calcolation for simplified TS. The script Simplified_TS_SDWBA.m has been revised and
		 the session name introduced as new input variable. For the "Average over a distribution of orientations" GUI interface,
	      a new script called "Calculate_Simplified_TS_SDWBA.m" has been introduced in the \bin folder 
	      to estimate the TS by using the simplified SDWBA (left lower panel).

