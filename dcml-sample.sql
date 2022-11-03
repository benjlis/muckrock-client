set search_path=covid19;
select setseed(.6);

update dcml_items
   set subset = 'train'
   where item_id in (select min(item_id)
                        from dcml_items
                        where pg_cnt <= 20 and
                              not covid_mentioned
                        group by file_hash
                        order by random()
                        limit 550);

update dcml_items
   set subset = 'train'
   where item_id in (select min(item_id)
                        from dcml_items
                        where pg_cnt <= 20 and
                              covid_mentioned
                        group by file_hash
                        order by random()
                        limit 450);
