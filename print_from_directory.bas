'PRINT FROM DIRECTORY.BAS
'This script prints multiple graphs using a graph template and several data files.
'Modify the paths in the script to match your template file path and data file path.
'Also exports to a GIF with the DAT name

Sub Main

  'Create Grapher as an object
  Dim Grapher As Object

  'Start Grapher
  Set Grapher = CreateObject("Grapher.Application")

  'Remove quote from the following line to make Grapher visible
  Grapher.Visible(1)

  'Open Grapher's Open dialog box
  '*******Change Directory to directory where DAT files are located********
  Directory = Grapher.Path+"\Samples\"
  file$ = Dir$(Directory + "*.dat")
  '*******Change the Template to the name and location where the GRT file is located**********
  Template = Grapher.Path+"\Templates\line scatter plot.grt"

  While file$ <> ""

    'Open the file in the directory in order
    Set doc = Grapher.Documents.Add(grfPlotDoc,Template,Directory+file$)

    'Create text with new date
    Set Text1 = doc.Shapes.AddText(0.5, 0.5, "<<mmmm dd, yyyy>> at <<hh:nn>> PDT")

     'Export to same named GIF
    doc.Export(Directory+Left(file$,Len(file$)-3)+"gif")

    'Close the plot window
    doc.Close(grfSaveChangesNo)

    'Open the next file
    file$ = Dir$()
  Wend

  'Close Grapher
  Grapher.Quit()

End Sub









This article contains a sample script for printing multiple graphs from a single template using all data files in a specified directory. Also shows how to export the graph to a GIF file and how to add to the plot the date/time the graph was created.

To run this script:

Copy the script below, or click here to download the BAS file: print from directory.bas.
In a Windows Explorer window, navigate to C:\Program Files\Golden Software\Grapher 12\Scripter.
Double click on Scripter.exe to launch Scripter.
Press Ctrl+A to select all of the existing lines then press Delete.
If you copied this script, press Ctrl+V to paste it into Scripter. If you downloaded it, click File | Open, select the BAS file from your downloads directory, and click Open.
Click Script | Run to run the script.
 
*********

'PRINT FROM DIRECTORY.BAS
'This script prints multiple graphs using a graph template and several data files.
'Modify the paths in the script to match your template file path and data file path.
'Also exports to a GIF with the DAT name

Sub Main

  'Create Grapher as an object
  Dim Grapher As Object

  'Start Grapher
  Set Grapher = CreateObject("Grapher.Application")

  'Remove quote from the following line to make Grapher visible
  Grapher.Visible(1)

  'Open Grapher's Open dialog box
  '*******Change Directory to directory where DAT files are located********
  Directory = Grapher.Path+"\Samples\"
  file$ = Dir$(Directory + "*.dat")
  '*******Change the Template to the name and location where the GRT file is located**********
  Template = Grapher.Path+"\Templates\line scatter plot.grt"

  While file$ <> ""

    'Open the file in the directory in order
    Set doc = Grapher.Documents.Add(grfPlotDoc,Template,Directory+file$)

    'Create text with new date
    Set Text1 = doc.Shapes.AddText(0.5, 0.5, "<<mmmm dd, yyyy>> at <<hh:nn>> PDT")

     'Export to same named GIF
    doc.Export(Directory+Left(file$,Len(file$)-3)+"gif")

    'Close the plot window
    doc.Close(grfSaveChangesNo)

    'Open the next file
    file$ = Dir$()
  Wend

  'Close Grapher
  Grapher.Quit()

End Sub
