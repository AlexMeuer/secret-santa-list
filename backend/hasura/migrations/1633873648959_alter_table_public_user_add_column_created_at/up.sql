alter table "public"."user" add column "created_at" timestamptz
 not null default now();
