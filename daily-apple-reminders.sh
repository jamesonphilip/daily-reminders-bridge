#!/usr/bin/env bash
# daily-apple-reminders.sh
#
# SAMPLE / EXAMPLE — this file is regenerated fresh each morning by the AI agent.
# Do not edit manually; your changes will be overwritten.
#
# Generated: 2026-04-16 05:30:00
# Children: Lola (age 7y 3m), Marlo (age 5y 1m), Hudson (age 2y 8m)

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

# ── Reminder 1 — Lola (age 7y 3m) ────────────────────────────────────────────
add_reminder \
    "Lola tip — Encourage autonomy" \
    "At 7, children thrive when given small choices with real consequences. Let Lola pick tonight's dinner vegetable and follow through — it builds executive function and trust. (Source: Deci & Ryan, self-determination theory)"

# ── Reminder 2 — Marlo (age 5y 1m) ───────────────────────────────────────────
add_reminder \
    "Marlo tip — Emotion labeling" \
    "Five-year-olds are still mapping feelings to words. When Marlo gets frustrated, narrate: 'You look really disappointed that we can't go yet.' This co-regulation scaffolds her own emotional vocabulary. (Source: Gottman emotion-coaching research)"

# ── Reminder 3 — Hudson (age 2y 8m) ──────────────────────────────────────────
add_reminder \
    "Hudson tip — Parallel play is connection" \
    "At 2–3, children play alongside others, not yet cooperatively. Sit near Hudson and do your own 'work' while he plays — your calm presence is co-regulation without intrusion. (Source: Parten's stages of play)"

# ── Reminder 4 — Marriage tip ─────────────────────────────────────────────────
add_reminder \
    "Marriage tip — 6-second kiss" \
    "The Gottman Institute's research shows a 6-second kiss daily creates a 'heat map' of physical connection. It's long enough to be intentional, short enough to do every morning before coffee."

# ── Reminder 5 — Relationship tip ────────────────────────────────────────────
add_reminder \
    "Relationship tip — Appreciation ratio" \
    "Healthy couples maintain a 5:1 positive-to-negative interaction ratio. Find one specific thing to appreciate out loud today — not 'you're great' but 'I noticed you handled bedtime solo last night.' (Source: Gottman ratio research)"

echo "All 5 reminders added successfully."
