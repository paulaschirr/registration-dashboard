# registration-dashboard
An interactive input terminal to register attendance to courses and events. This shiny dashboard was designed to replace the pen and paper attendance registration lists at the technical college FTWV in Wilhelmshaven, Germany. Pen and paper lists for attendance are prone to error.

The shiny app creates a user interface that can be run locally on a registration terminal (computer in the entry hall of the technical college). Every course attendant receives an ID to avoid errors due to variations in names or misspelling. To run the app, install R and Rstudio locally on your machine. Download app.R, ID-key.csv and www folder (containing college logo). Before running the dashboard for the first time, all required packages have to be installed (uncomment and run line 1-3, in the following these lines are not needed, so comment out).

The app draws on the ID-key data in the csv file. Replace the sample data with IDs and names of students. IDs that are not stored in the ID-key.csv will not be recorded on the registration list, as they are not associated with a name. Duplicate entries of an ID within the same day will also not appear on the registration list. All registration data is stored in registration-all.csv, which is either created new (if not present in the same directory) or the new data is added to the csv.
Every week on Monday, last week's registration data is sent to the administrator via email for further analysis and attendance certification.

