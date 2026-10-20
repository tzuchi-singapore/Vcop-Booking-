<p align="center">
  <img src="docs/hero.jpg" alt="VCOP Job Booking App" width="100%">
</p>

# VCOP Job Booking App (JBA)

An internal web app that digitises VCOP's **project delivery & installation operation** — replacing the email + shared-spreadsheet workflow with a single, bilingual (English / 中文) booking system.

It runs as **one self-contained `index.html`** (no build step, no framework) and saves to **Supabase**. Deployable to GitHub Pages in minutes.

> **Live app:** https://tzuchi-singapore.github.io/Vcop-Booking-/

---

## What it does

Built around VCOP's actual 6-step operation methodology:

1. **Requester submits** — a project planner / PM raises a job using the digital Project Summary form (project info, purchase-order lines, layout plans & drawings).
2. **Administrator reviews** scope, intensity and quantum.
3. **Administrator assigns** a project manager + one of the installation teams, with manpower.
4. The job is **scheduled** on the calendar (replaces the manual Excel entry).
5. The **installation team is briefed** before the job date.
6. **Delivery & installation** is completed on site and **signed off**.

---

## Features

### Requester (project planners / PMs)
- Digital **Project Summary form**: title, address, site contact, Sales/PIC, job type (Delivery / Installation / Dismantle / Disposal / Site survey).
- **Purchase-order table** — unlimited lines: Supplier · PO No. · Items · Qty · ETA · Delivery date · Remarks.
- DO preparation (quotation no.), return goods, disposal, special instructions.
- **Requested delivery/installation date** (calendar) + **scroll time picker**.
- **Attachments** — layout plans, 3D visuals, drawings, the Project Summary file (up to 20 MB each, stored in Supabase Storage).
- Auto **WhatsApp** notification to operations on submit.
- **Add to calendar** (Google Calendar + `.ics`).
- On-site **completion sign-off** signature.

### Administrator
- Secret access: **tap the VCOP logo 3 times**, then enter the admin password.
- **Jobs** — review each request in full (incl. opening attachments) and **assign PM + installation team + manpower + scheduled date/time + notes**; the requester is notified on WhatsApp.
- **Calendar** — all scheduled jobs by day.
- **Requesters** — create / edit accounts and reset passwords.
- **Teams / PM** — manage the installation teams and project managers.
- **Block dates** — mark no-delivery days.
- **Export** — CSV, or a printable report (with sign-off signatures) that replaces the shared spreadsheet.

### Everywhere
- 🇬🇧 **English / 中文** toggle.
- VCOP branding and logo.
- Works on phone, tablet and desktop.

---

## Setup

### 1. Database (Supabase)
1. Create a project at [supabase.com](https://supabase.com).
2. Open **SQL Editor → New query**, paste the contents of [`supabase-setup.sql`](supabase-setup.sql) and **Run**. This creates the tables **and** the `attachments` storage bucket.
3. In **Project Settings → API**, copy your **Project URL** and **anon public key**.
4. In `index.html`, set them in the `CONFIG` block near the top:
   ```js
   SUPABASE_URL:  "https://YOUR-PROJECT.supabase.co",
   SUPABASE_ANON_KEY: "YOUR-ANON-KEY",
   ```

> Without these, the app still runs in **demo mode** (data kept only for the session). Demo login: `demo` / `demo123`.

### 2. Deploy (GitHub Pages)
Already enabled for this repo — any push to `main` publishes to the live URL above. The entry file must stay named **`index.html`**.

---

## Configuration

All settings live in the `CONFIG` object at the top of `index.html`:

| Setting | Purpose |
|---|---|
| `ADMIN_PASSWORD` | Administrator password (3-tap the logo to reach login) |
| `WHATSAPP_NUMBER` | Operations WhatsApp number for notifications |
| `BUSINESS` | Company address, phone, email, socials |
| `JOB_TYPES` | The selectable job types |
| `MAX_FILE_MB` | Attachment size limit (default 20 MB) |
| `OPEN_HOUR` / `CLOSE_HOUR` | Time-picker range |

---

## ⚠️ Security notes

This is a **public repository**, and the app is **fully client-side**. That means:

- The **admin password** and the **Supabase anon key** in `index.html` are visible to anyone who views the page source.
- The setup SQL uses **open access policies** so the anon key can read/write all tables.

This is acceptable for a small, trusted internal rollout, but for production you should harden it:
- Move the repository to **private**, or move admin auth and data access behind **Supabase Auth** with proper row-level security.
- Rotate the admin password regularly.

See the project owner (Daniel Phua) before changing access settings.

---

## Tech

- Single-file **HTML + CSS + vanilla JavaScript** (no build).
- [Supabase](https://supabase.com) for database + file storage.
- Hosted on **GitHub Pages**.

---

## License

© 2026 VCOP Pte Ltd. All rights reserved. See [LICENSE](LICENSE).
