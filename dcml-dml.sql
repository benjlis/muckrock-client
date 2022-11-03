set search_path='covid19';

-- load non covid coronavirus docs int load table
truncate table muckml_load;
\copy muckml_load(id, user_id, organization, access, status, title, slug, source, language, created_at, updated_at, page_count, original_extension, file_hash, related_article, edit_access, notes, highlights, data, asset_url, canonical_url, description, published_url, projects) from 'muckrock-ml-non-covid.csv' DELIMITER ',' CSV HEADER;
-- copy the columns with data to dcml_items
insert into dcml_items (item_id, title, slug, created_at, updated_at, pg_cnt,
    file_hash, related_article, data_tags, canonical_url,
    projects, covid_mentioned)
select id::integer, title, slug, created_at::timestamptz, updated_at::timestamptz,
       page_count::integer, file_hash, related_article, data, canonical_url,
       projects, 'N'
from muckml_load;

-- load covid coronavirus docs into load table
truncate table muckml_load;
\copy muckml_load(id, user_id, organization, access, status, title, slug, source, language, created_at, updated_at, page_count, original_extension, file_hash, related_article, edit_access, notes, highlights, data, asset_url, canonical_url, projects, description, published_url) from 'muckrock-ml-covid.csv' DELIMITER ',' CSV HEADER;
-- copy the columns with data to dcml_items
insert into dcml_items (item_id, title, slug, created_at, updated_at, pg_cnt,
    file_hash, related_article, data_tags, canonical_url,
    projects, covid_mentioned)
select id::integer, title, slug, created_at::timestamptz, updated_at::timestamptz,
       page_count::integer, file_hash, related_article, data, canonical_url,
       projects, 'Y'
from muckml_load;
