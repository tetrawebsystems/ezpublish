UPDATE ezsite_data SET value='3.4.0alpha3' WHERE name='ezpublish-version';
UPDATE ezsite_data SET value='3' WHERE name='ezpublish-release';

ALTER TABLE ezcontentclass ADD COLUMN remote_id varchar(100) NOT NULL;
ALTER TABLE ezcontentclass ALTER remote_id SET default '';

ALTER TABLE ezcontentobject_tree ADD COLUMN remote_id varchar(100) NOT NULL;
ALTER TABLE ezcontentobject_tree ALTER remote_id SET default '';

ALTER TABLE eznode_assignment ADD COLUMN node_remote_id varchar(100) NOT NULL;
ALTER TABLE eznode_assignment ALTER node_remote_id SET default '';
