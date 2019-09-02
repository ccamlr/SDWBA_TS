-----------------------------------------
SDWBA Target Strength calculation package
Stephane Conti - 03 June 2005
Contact: stephane.conti@noaa.gov
-----------------------------------------

The matlab programs provided with this package allow to calculate the SDWBA Target Strength for a krill.

Running the program ProcessKrillEupSDWBATS gives three options:
	- calculate the Target Strength
	- Average the Target Strength over a distribution of orientations
	- Exit the program.

In the first case, the different parameters for the model can be changed from the default values.
Once the model has been run, the choice is offered to calculate a new model, or average over a distribution of orientations.

After averaging the TS over a given distribution of orientation, it is possible to either click on a figure to estimate the TS at given frequencies, or Exit the program and estimate the simplified TS for a range of frequencies and length of the animal.

The generated TS before the orientation distribution average is saved under the specified filename and folder. This file is used for the orientation distribution average.

After the orientation average, a file is saved with the specified filename, plus the characteristics of the distribution used.