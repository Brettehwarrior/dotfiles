import json
import subprocess
import utility

focused_monitor_index = utility.get_focused_monitor_index()
monitors_string = subprocess.run(['glazewm', 'query', 'monitors'], capture_output=True, text=True)
monitor_count = len(json.loads(monitors_string.stdout)['data']['monitors'])
next_monitor_index = (focused_monitor_index + 1) % monitor_count

subprocess.run(['glazewm', 'command', 'focus', '--monitor', str(next_monitor_index)])
