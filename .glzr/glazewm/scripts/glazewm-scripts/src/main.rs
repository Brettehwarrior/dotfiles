#![windows_subsystem = "windows"]

use std::process::Command;
use std::os::windows::process::CommandExt;
use std::env;
use serde_json::json;

const CREATE_NO_WINDOW: u32 = 0x0800_0000;

fn get_focused_monitor_index() -> i32 {
    let output = Command::new("glazewm")
        .args(&["query", "monitors"])
        .creation_flags(CREATE_NO_WINDOW)
        .output()
        .expect("Failed to execute glazewm command");

    let stdout = String::from_utf8(output.stdout)
        .expect("Failed to convert stdout to string");

    let monitors_data: serde_json::Value = serde_json::from_str(&stdout)
        .expect("Failed to parse JSON");

    let monitors = monitors_data["data"]["monitors"]
        .as_array()
        .expect("monitors should be an array");

    monitors
        .iter()
        .position(|m| m.get("hasFocus").and_then(|v| v.as_bool()).unwrap_or(false))
        .map(|i| i as i32)
        .unwrap_or(-1)
}

fn main() {
    let args : Vec<String> = env::args().collect();
    let workspace_index = &args[1];

    let monitor_index = get_focused_monitor_index();
    println!("hey guys {}", monitor_index);
    let workspace_name = format!("{}_{}", monitor_index, workspace_index);
    let output = Command::new("glazewm")
        .args(&["command", "focus", "--workspace", &workspace_name])
        .creation_flags(CREATE_NO_WINDOW)
        .output()
        .expect("Failed to execute glazewm command");
    let stdout = String::from_utf8(output.stdout)
        .expect("Failed to convert stdout to string");
    println!("{}", stdout);
}