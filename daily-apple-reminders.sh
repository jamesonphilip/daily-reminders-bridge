#!/usr/bin/env bash
# daily-apple-reminders.sh
#
# SAMPLE / EXAMPLE — this file is regenerated fresh each morning by the AI agent.
# Do not edit manually; your changes will be overwritten.
#
# Generated: YYYY-MM-DD 05:30:00
# Children: Child1 (age Xy Ym), Child2 (age Xy Ym), Child3 (age Xy Ym)

set -euo pipefail

DUE_TIME="6:00 AM"
LIST_NAME="Reminders"   # change to your preferred Reminders list name

# ── Helper: create one reminder via AppleScript ───────────────────────────────
add_reminder() {
    local title="$1"
    local body="$2"
    osascript <<APPLESCRIPT
tell application "Reminders"
    set dueDate to (current date)
    set hours of dueDate to 6
    set minutes of dueDate to 0
    set seconds of dueDate to 0

    tell list "$LIST_NAME"
        set newReminder to make new reminder with properties ¬
            {name:"$title", body:"$body", due date:dueDate, remind me date:dueDate}
    end tell
end tell
APPLESCRIPT
    echo "Added reminder: $title"
}

# ── Reminder 1 — Child1 (age 7y) ─────────────────────────────────────────────
add_reminder \
    "Child1 tip — Encourage autonomy" \
    "At 7, children thrive when given small choices with real consequences. Let Child1 pick tonight's dinner vegetable and follow through — it builds executive function and trust. (Source: Deci & Ryan, self-determination theory)"

# ── Reminder 2 — Child2 (age 5y) ─────────────────────────────────────────────
add_reminder \
    "Child2 tip — Emotion labeling" \
    "Five-year-olds are still mapping feelings to words. When Child2 gets frustrated, narrate: 'You look really disappointed that we can't go yet.' This co-regulation scaffolds their own emotional vocabulary. (Source: Gottman emotion-coaching research)"

# ── Reminder 3 — Child3 (age 2y) ─────────────────────────────────────────────
add_reminder \
    "Child3 tip — Parallel play is connection" \
    "At 2–3, children play alongside others, not yet cooperatively. Sit near Child3 and do your own 'work' while they play — your calm presence is co-regulation without intrusion. (Source: Parten's stages of play)"

# ── Reminder 4 — Marriage tip ─────────────────────────────────────────────────
add_reminder \
    "Marriage tip — 6-second kiss" \
    "The Gottman Institute's research shows a 6-second kiss daily creates a 'heat map' of physical connection. It's long enough to be intentional, short enough to do every morning before coffee."

# ── Reminder 5 — Relationship tip ────────────────────────────────────────────
add_reminder \
    "Relationship tip — Appreciation ratio" \
    "Healthy couples maintain a 5:1 positive-to-negative interaction ratio. Find one specific thing to appreciate out loud today — not 'you're great' but 'I noticed you handled bedtime solo last night.' (Source: Gottman ratio research)"

echo "All 5 reminders added successfully."
