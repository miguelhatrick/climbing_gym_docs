DROP TABLE miss_p_id ;
CREATE TEMPORARY TABLE miss_p_id AS 
SELECT p.id as id, mm.name, p.firstname, p.lastname, string_agg(DISTINCT(pc.name), ', ') as tags
	FROM public.climbing_gym_event_monthly_content as emc
	left join public.climbing_gym_member_membership as mm on emc.member_membership_id = mm.id
	left join public.res_partner as p on p.id = mm.partner_id
	left join public.res_partner_res_partner_category_rel as pcr on p.id = pcr.partner_id
	left join public.res_partner_category as pc on pcr.category_id = pc.id
	where emc.event_monthly_group_id = 7 and emc.state = 'confirmed'
	GROUP by mm.name, p.id;
	
select 	* from miss_p_id as i where  i.tags not like '%APTO PALESTRA%' or i.tags is null order by i.name;

select * from public.res_partner_category as pc where pc.id = 9;

select * from public.res_partner_res_partner_category_rel limit 1

insert into public.res_partner_res_partner_category_rel
(category_id, partner_id)
select 9 as category_id,	id as partner_id from miss_p_id as i where  i.tags not like '%APTO PALESTRA%' or i.tags is null order by i.name;
