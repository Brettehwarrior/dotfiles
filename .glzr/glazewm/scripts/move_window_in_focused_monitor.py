import sys
import subprocess
import utility

focused_monitor_index = utility.get_focused_monitor_index()
focused_workspace_index = sys.argv[1] # Provided by GlazeWM hotkey
workspace_id = f'{focused_monitor_index}_{focused_workspace_index}'

subprocess.run(['glazewm', 'command', 'move', '--workspace', workspace_id])
subprocess.run(['glazewm', 'command', 'focus', '--workspace', workspace_id])
