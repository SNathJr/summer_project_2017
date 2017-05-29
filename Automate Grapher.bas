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
  Directory = "D:\Summer_Project_2017\TESTRUNs\grphr\"
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

