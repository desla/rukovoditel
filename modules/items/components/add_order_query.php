<?php

foreach(explode(',',$_POST['listing_order_fields']) as $key=>$order_field)
{
  if(strlen($order_field)==0) continue; 
  
  $order = explode('_',$order_field);
  
  $alias = 'fc' . $key;
  
  $field_id = $order[0];
  $order_cause =  $order[1]; 
  
  $field_info_query = db_query("select * from app_fields where id='" . db_input($field_id) . "'");
  if($field_info = db_fetch_array($field_info_query))
  {
    $listing_order_fields_id[]=$field_id;
    $listing_order_clauses[$field_id] = $order_cause;
            
    if(in_array($field_info['type'],array('fieldtype_created_by','fieldtype_date_added','fieldtype_id')))
    {
      $listing_order_fields[] = 'e.' . str_replace('fieldtype_','',$field_info['type']) . ' ' . $order_cause;
    }
    elseif(in_array($field_info['type'],array('fieldtype_dropdown')))
    {
      $listing_sql_query_join .= " left join app_fields_choices {$alias} on {$alias}.id=e.field_" . $field_id;
      $listing_order_fields[] = "{$alias}.sort_order " . $order_cause . ", {$alias}.name " . $order_cause;
    }
    elseif(in_array($field_info['type'],array('fieldtype_input_numeric','fieldtype_input_numeric_comments','fieldtype_date_added','fieldtype_input_date','fieldtype_input_datetime')))
    {
      $listing_order_fields[] = '(e.field_' . $field_id . '+0) ' . $order_cause;
    }
    elseif(in_array($field_info['type'],array('fieldtype_formula')))
    {
      $listing_order_fields[] = 'field_' . $field_id . ' ' . $order_cause;
    }
    else
    {
      $listing_order_fields[] = 'e.field_' . $field_id . ' ' . $order_cause;
    }
  }
}



if(count($listing_order_fields)>0)
{
  $listing_sql_query .= " order by " . implode(',',$listing_order_fields);
}
else
{
  $listing_sql_query .= " order by e.id ";
}