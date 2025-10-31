# Linking Mendeley with Overleaf
## To dynamically update bibliography

Author: Hannah Vineer

Date: 30-10-2025

### Create a "Group" in Mendeley Desktop
Add all of your references to this group, then sync to Mendeley Web.

### Link a .bib file in Overleaf to Mendeley
Within your Overleaf project, select "New File" --> "From Mendeley" --> select the Mendeley Group. 
If you haven't previously linked Overleaf with your Mendeley account, you will be prompted to do so before you can select the Group.

### Check the references
You will now have a new .bib file in your left hand pane. Click on the file and you should see an option to refresh. Do this every time you edit your references within Mendeley to ensure changes are synced with Overleaf.

### Editing your references
If you find an error with your references within Overleaf, or want to add more references, DO NOT directly edit the .bib file. Make your changes in Mendeley and then 1) sync Mendeley with Mendeley Web, and 2) refresh your .bib file within Overleaf. 

### Citations and Bibliography
There are many ways to add citations in Overleaf. I like natbib <https://www.overleaf.com/learn/latex/Bibliography_management_with_natbib>. If you're using a journal template for your Overleaf project, they will usually specify how to include citations and a reference list. 

### Italicising species names within paper titles in the bibliography
I have not found a good way to do this with the dyanmic link to the .bib file, so this is my workaround...

- Once you've finished your bibliography, make a copy within your Overleaf project
- Make sure you point to the new (fixed) copy in your .tex file
- Edit the fixed .bib file to use \emph{} to italicise species' names
- If you then need to add a reference to your fixed file, you can add it to your dynamic .b. and then copy it over manually to the fixed one. So the above steps are best done when your bibliography is finalised (i.e. ready for submission).
