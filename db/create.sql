DROP TABLE IF EXISTS "employee";
CREATE TABLE "employee" (
  "employee_id"           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "ee_number"             text NOT NULL,
  "first_name"            text NOT NULL,
  "last_name"             text NOT NULL,
  "address"               text NOT NULL,
  "last_info_change_id"   INTEGER NOT NULL DEFAULT -1,
  UNIQUE(employee_id),
  FOREIGN KEY ("last_info_change_id")   REFERENCES "employee_event"("employee_event_id")
);

DROP TABLE IF EXISTS "employee_event";
CREATE TABLE "employee_event" (
  "employee_event_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "employee_id"       INTEGER NOT NULL,
  "event"             VARCHAR(32) NOT NULL,
  "triggered_on"      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "details"           LONGTEXT,
  UNIQUE(employee_event_id),
  FOREIGN KEY ("employee_id") REFERENCES "employee"("employee_id") ON UPDATE CASCADE
);
CREATE INDEX "employee_event_idx" ON "employee_event" ("employee_id", "event", "triggered_on")
