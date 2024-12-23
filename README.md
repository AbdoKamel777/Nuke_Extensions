# Nuke_Extensions

These Tools work only with Python 3 and Nuke 15 


installing :
just run the batch file and it will copy the files into your .nuke folder and add the commands to the menu file 


if you having issues in installing you can install it manually by creating file named "Nuke_Tools_Extensions "
and then copy the :
Recent_Projects.pyc
Render_History.pyc
nuke_Logo.png 
to it and then copy and past the "Nuke_Tools_Extensions " folder to your .nuke 
and last step add this command to your menu.py


nuke_tools_path = os.path.join(os.path.expanduser("~"), ".nuke", "Nuke_Tools_Extensions") 
sys.path.append(nuke_tools_path) 
import Recent_Projects 
from Render_History import show_render_history 
nuke.menu('Nuke').addCommand('Render History', show_render_history, 'ctrl+r') 


and it will be installed ;)


