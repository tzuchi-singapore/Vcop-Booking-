# Changelog

All notable changes to the VCOP Job Booking App.

## [2.0.0] — 2026-10-20
Reframed from a client appointment booker into the **Job Booking App (JBA)** that
matches VCOP's real delivery & installation operation.

### Added
- Role model: **Requester** (project planners / PMs) and **Administrator**.
- Digital **Project Summary form** with an unlimited **purchase-order table**
  (Supplier · PO · Items · Qty · ETA · Delivery date · Remarks).
- Job fields: DO preparation, return goods, disposal, special instructions, site contact, Sales/PIC.
- **Attachments** (layout plans, 3D visuals, drawings, Project Summary) via Supabase Storage, up to 20 MB each.
- Admin **assignment**: project manager + installation team + manpower + scheduled date/time + notes.
- Admin **Calendar** view, **Teams / PM** management, and **Export** (CSV + printable report with sign-off).
- On-site **completion sign-off** signature.
- Status lifecycle: Submitted → Assigned → Completed.
- WhatsApp notifications on submit and on assignment.
- Hero image and refreshed VCOP branding.

### Changed
- Calendar + scroll time picker reused for the requested delivery/installation slot.
- Supabase schema: `requesters`, `jobs`, `blocks`, `resources` (+ `attachments` storage bucket).

### Retained
- English / 中文 toggle.
- Secret admin access (3-tap the logo).
- VCOP company landing page, map and contacts.
