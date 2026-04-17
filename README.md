# daily-reminders-bridge

macOS LaunchAgent + AI-generated AppleScript for daily personalized parenting and relationship reminders.

Every morning at 6 AM, five Apple Reminders appear in your Reminders app:

- **3 child development tips** — personalized to your kids' names and exact ages, grounded in peer-reviewed research
- **2 marriage/relationship tips** — drawn from relationship science (Gottman, attachment theory, etc.)

The content is fresh every single day. No repeated reminders, no generic advice.

---

## How It Works

```
5:30 AM  Claude AI agent (Cowork scheduled task)
           │
           │  writes a fresh daily-apple-reminders.sh
           │  (5 osascript blocks, personalized to your family)
           ▼
6:01 AM  macOS LaunchAgent  (.reminders-runner.sh)
           │
           │  executes daily-apple-reminders.sh
           ▼
        Apple Reminders app
           │
           └── Lola tip (due 6:00 AM)
           └── Marlo tip (due 6:00 AM)
           └── Hudson tip (due 6:00 AM)
           └── Marriage tip (due 6:00 AM)
           └── Relationship tip (due 6:00 AM)
```

The AI agent generates a new shell script each morning containing five AppleScript blocks. The LaunchAgent fires 31 minutes later and executes whatever script is sitting in the repo folder. The two pieces are decoupled by design — the LaunchAgent doesn't care how the script was generated.

---

## Prerequisites

- macOS (Ventura or later recommended)
- Apple Reminders app (built into macOS)
- A Claude Cowork account (or any AI agent platform that can write a file on a schedule)
- Terminal access to run the one-time setup

---

## Setup

### 1. Clone the repo

```bash
git clone https://github.com/jamesonphilip/daily-reminders-bridge.git
cd daily-reminders-bridge
```

### 2. Run the setup script

```bash
bash setup-daily-reminders-bridge.sh
```

This script is **self-discovering** — it finds its own location on disk and hard-codes the correct absolute paths into all generated files. It:

- Creates `.reminders-runner.sh` in the same folder (the actual LaunchAgent payload)
- Installs `~/Library/LaunchAgents/com.jameson.daily-reminders.plist`
- Loads the LaunchAgent (it will fire automatically at 6:01 AM every day)

### 3. Connect your AI agent

Configure a Claude Cowork scheduled task (or equivalent) to run at **5:30 AM daily**. The prompt should instruct the agent to write a fresh `daily-apple-reminders.sh` to the path printed by the setup script.

A minimal prompt template:

> Write a bash script to `/path/to/daily-reminders-bridge/daily-apple-reminders.sh` that creates 5 Apple Reminders due at 6:00 AM today using osascript. Include 3 child development tips personalized to: Lola (born YYYY-MM-DD), Marlo (born YYYY-MM-DD), Hudson (born YYYY-MM-DD) — use their exact current ages and cite peer-reviewed research. Include 2 marriage/relationship tips grounded in relationship science. See the sample script in the repo for the expected structure.

---

## How the Generated Script Works

Each `daily-apple-reminders.sh` is a standard bash script that calls `osascript` five times. Each call runs an AppleScript block like this:

```applescript
tell application "Reminders"
    set dueDate to (current date)
    set hours of dueDate to 6
    set minutes of dueDate to 0
    set seconds of dueDate to 0

    tell list "Reminders"
        set newReminder to make new reminder with properties ¬
            {name:"Lola tip — ...", body:"...", due date:dueDate, remind me date:dueDate}
    end tell
end tell
```

The `remind me date` property is what triggers the notification at 6 AM. The `body` field contains the full tip text.

---

## Customization

**Change children's names or birthdates**
Update the prompt you give your AI agent. The AI calculates exact ages at generation time — no configuration file needed.

**Change the Reminders list**
Edit the `LIST_NAME` variable near the top of `daily-apple-reminders.sh` (the sample), and update your AI prompt to use the same list name.

**Change the reminder time**
- In your AI agent prompt: change `6:00 AM` to your preferred time
- In `setup-daily-reminders-bridge.sh`: change `Hour` and `Minute` in the plist block before re-running setup

**Change the topics**
Add categories (fitness, gratitude, financial goals) by updating the AI agent prompt. The script structure supports any number of reminders.

---

## Troubleshooting

**Reminders aren't appearing**

Check the log file:
```bash
cat /tmp/daily-reminders.log
```

Common causes:
- `daily-apple-reminders.sh` wasn't written by the AI agent before 6:01 AM — check the Cowork scheduled task
- Reminders app doesn't have automation permission — go to System Settings → Privacy & Security → Automation and allow Terminal/your shell

**LaunchAgent stopped firing**

Re-run setup to reload it:
```bash
bash setup-daily-reminders-bridge.sh
```

Or reload manually:
```bash
launchctl unload ~/Library/LaunchAgents/com.jameson.daily-reminders.plist
launchctl load ~/Library/LaunchAgents/com.jameson.daily-reminders.plist
```

**Test it right now without waiting for 6 AM**

```bash
bash daily-apple-reminders.sh
```

---

## File Reference

| File | Description |
|------|-------------|
| `setup-daily-reminders-bridge.sh` | One-time setup — run this first |
| `daily-apple-reminders.sh` | Sample generated script (overwritten daily by AI agent) |
| `.reminders-runner.sh` | Auto-generated LaunchAgent payload (gitignored — machine-specific) |
| `~/Library/LaunchAgents/com.jameson.daily-reminders.plist` | LaunchAgent (installed by setup, not in repo) |

> **Note:** `daily-apple-reminders.sh` is regenerated fresh each morning by the AI agent and should not be edited manually — changes will be overwritten at 5:30 AM.

---

## License

MIT
