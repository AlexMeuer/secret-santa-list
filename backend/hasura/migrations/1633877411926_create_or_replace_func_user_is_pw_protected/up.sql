CREATE OR REPLACE FUNCTION public.user_is_password_protected(user_row "user")
 RETURNS boolean
 LANGUAGE sql
 STABLE
AS $function$
  SELECT user_row.password IS NOT NULL AS BOOLEAN
$function$;
