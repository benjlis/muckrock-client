set search_path=covid19;
create table muckml_load (
	 id 	     text,
	 user_id 	 text,
	 organization 	 text,
	 access 	 text,
	 status 	 text,
	 title 	 text,
	 slug 	 text,
	 source 	 text,
	 language 	 text,
	 created_at 	 text,
	 updated_at 	 text,
	 page_count 	 text,
	 original_extension 	 text,
	 file_hash 	 text,
	 related_article 	 text,
	 edit_access 	 text,
	 notes 	 text,
	 highlights 	 text,
	 data 	 text,
	 asset_url 	 text,
	 canonical_url 	 text,
	 description 	 text,
	 published_url 	 text,
	 projects 	 text
);
\copy muckml_load(id, user_id, organization, access, status, title, slug, source, language, created_at, updated_at, page_count, original_extension, file_hash, related_article, edit_access, notes, highlights, data, asset_url, canonical_url, description, published_url, projects) from 'muckrock-ml-non-covid.csv' DELIMITER ',' CSV HEADER;
