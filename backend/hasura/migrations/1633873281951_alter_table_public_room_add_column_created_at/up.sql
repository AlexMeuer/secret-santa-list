alter table "public"."room" add column "created_at" timestamptz
 null default now();
