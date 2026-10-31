import json
import subprocess

def get_focused_monitor_index() -> int:
    monitors_string = subprocess.run(['glazewm', 'query', 'monitors'], capture_output=True, text=True)
    monitors = json.loads(monitors_string.stdout)['data']['monitors']

    focused_monitor_index = next((i for i, m in enumerate(monitors) if m.get('hasFocus')), -1)
    return focused_monitor_index