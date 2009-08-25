
-record(item_type, { item_type_name, parent_item_type_name }).

-record(item_type_attributes, { item_type_attribute_name }).

-record(item_type_has_attribute, { item_type_name, item_type_attribute_name }).

-record(item_type_attribute_value, { item_type_name, item_type_attribute_name, item_type_attribute_value }).

